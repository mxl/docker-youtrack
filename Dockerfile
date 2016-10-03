FROM debian:jessie
MAINTAINER Michael Ledin "mledin89@gmail.com"

ENV USER=youtrack

RUN useradd -d /$USER -m -U $USER

RUN echo 'deb http://http.debian.net/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list \ 
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends wget openjdk-8-jre-headless

RUN wget -O /$USER/$USER.jar https://download.jetbrains.com/charisma/youtrack-7.0.27505.jar

RUN apt-get remove -y --purge --auto-remove wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY . /$USER

RUN chown -R $USER:$USER /$USER

EXPOSE 8080

USER $USER

ENV VAR=/$USER/var DATA=/$USER/teamsysdata

RUN mkdir $VAR $DATA

VOLUME $VAR $DATA

WORKDIR /$USER

CMD /$USER/$USER.sh
