FROM debian:jessie
MAINTAINER Michael Ledin "mledin89@gmail.com"

ENV USER youtrack
ENV BASE_URL http://localhost

RUN useradd -d /$USER -m -U $USER

RUN echo 'deb http://http.debian.net/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list \ 
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -t jessie-backports install -y --no-install-recommends wget openjdk-8-jre-headless

ENV YOUTRACK_VERSION=2017.1.30973

RUN wget -O /$USER/$USER.jar https://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar

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
