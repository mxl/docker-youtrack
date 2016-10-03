#! /bin/sh

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre

PORT=8080
JAR=/$USER/$USER.jar
VAR=/$USER/var
LOG=$VAR/$USER.log

exec $JAVA_HOME/bin/java \
    -Xmx1g -Djava.awt.headless=true \
    -Djava.security.egd=/dev/zrandom \
    -Djavax.net.ssl.trustStore=$JAVA_HOME/lib/security/cacerts \
    -jar $JAR $PORT 2>&1
