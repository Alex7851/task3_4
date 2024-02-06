FROM jrei/systemd-debian
# RUN apt update && \
#     apt install -y openjdk-11-jdk
COPY app /etc/default/app
COPY looksdemo-3.13.1.jar /usr/local/bin/looksdemo-3.13.1.jar
COPY test-java.service /lib/systemd/system/test-java.service
WORKDIR /usr/local/bin
#CMD java -Xms256m -Xmx512m -server