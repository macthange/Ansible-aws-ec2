FROM amazoncorretto:8

LABEL name="data-composite"
LABEL fullname="data-composite-app"
LABEL version={{version}}


ENV VERSION {{version}}
ENV JAVA_APP_JAR rest-service-composite-2.1-SNAPSHOT-exec.jar
ENV LISTEN_PORT=8080
ENV MGMT_LISTEN_PORT=8080
EXPOSE 8080

# Install needed general stuff
RUN mkdir -p /etc/cron.d && rm -rf /var/cache/yum \
     yum -y update \
     yum -y install util-linux wget jq unzip procps \
     yum -y install python3 python3-pip && \
     pip-3 install --upgrade pip && \
     pip install awscli && \
     aws configure set default.region us-east-1

COPY ./docker-entry-point.sh /

RUN chmod 755 /docker-entry-point.sh

COPY ./target /java-app/com/tr/app_data/composite/

WORKDIR /java-app/com/tr/dats-common/composite/

CMD /docker-entry-point.sh $Tag && java -javaagent:./aspectj-runtime/spring-instrument.jar -javaagent:./aspectj-runtime/aspectjweaver.jar $JAVA_OPTIONS -Dsp-eventSourceVersion=$Tag -Dserver.port=$LISTEN_PORT -Dmanagement.port=$MGMT_LISTEN_PORT -Dapt-config-path=./config -jar $JAVA_APP_JAR
