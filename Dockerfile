FROM ubuntu:14.04
MAINTAINER Vadym Popov <me@vpopov.org>

RUN adduser --system --disabled-password --group cicd
# RUN usermod -a -G docker cicd

RUN apt-get update && apt-get install -y curl supervisor openssh-server
RUN curl http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list && apt-get update
# HACK: https://issues.jenkins-ci.org/browse/JENKINS-20407
RUN mkdir /var/run/jenkins /var/log/jenkins /home/cicd/.jenkins
RUN apt-get install -y jenkins
RUN chown -R cicd:cicd /var/log/jenkins /var/run/jenkins /home/cicd/.jenkins

ADD .ssh /home/cicd/.ssh
ADD etc /home/cicd/etc

RUN cp -R --remove-destination /home/cicd/etc/* /etc

EXPOSE 8080
# ENV SOME_CONST test
# VOLUME ["/home/cicd/.jenkins"]

CMD ["/usr/bin/supervisord"]

