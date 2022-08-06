FROM ubuntu:jammy
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@znmeb.net>"
ARG DEBIAN_FRONTEND=noninteractive

# define envars

# virtual desktop
ENV DAISY_DEV_HOME=/home/daisy-dev
ENV DAISY_DEV_SCRIPTS=$DAISY_DEV_HOME/Scripts
ENV DAISY_DEV_LOGS=$DAISY_DEV_HOME/Logs
ENV DAISY_DEV_PROJECTS=$DAISY_DEV_HOME/Projects
ENV DAISY_DEV_NOTEBOOKS=$DAISY_DEV_HOME/Notebooks
ENV DAISY_DEV_WHEELS=$DAISY_DEV_HOME/Wheels

# set up 'daisy-dev' account
COPY docker-scripts/daisy-dev-user.sh /
RUN /daisy-dev-user.sh > /daisy-dev-user.log 2>&1

# enable passwordless sudo for 'daisy-dev'
COPY docker-scripts/passwordless-sudo /etc/sudoers.d/

# make virtual desktop
RUN mkdir --parents \
  $DAISY_DEV_SCRIPTS \
  $DAISY_DEV_LOGS \
  $DAISY_DEV_PROJECTS \
  && chown -R daisy-dev:daisy-dev $DAISY_DEV_HOME

USER daisy-dev
WORKDIR $DAISY_DEV_HOME
CMD [ "/bin/bash" ]

# Installing Mambaforge
COPY --chown=daisy-dev:daisy-dev Home/Scripts/mambaforge.sh $DAISY_DEV_SCRIPTS/
RUN $DAISY_DEV_SCRIPTS/mambaforge.sh > $DAISY_DEV_LOGS/mambaforge.log 2>&1

# Creating fresh mamba environment 'daisy-dev'
COPY --chown=daisy-dev:daisy-dev Home/Scripts/daisy-dev* $DAISY_DEV_SCRIPTS/
RUN /usr/bin/time $DAISY_DEV_SCRIPTS/daisy-dev.sh > $DAISY_DEV_LOGS/daisy-dev.log 2>&1

# Installing home directory scripts
COPY --chown=daisy-dev:daisy-dev \
  Home/bash_aliases \
  Home/edit-me-then-run-4-git-config.sh \
  Home/set-vim-background.sh \
  $DAISY_DEV_HOME/
RUN cat $DAISY_DEV_HOME/bash_aliases >> $DAISY_DEV_HOME/.bash_aliases

# Finished!
