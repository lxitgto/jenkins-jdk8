FROM jenkins
MAINTAINER ethan.liu@wezebra.com

# if we want to install via apt
USER root

# install git
RUN apt-get update && apt-get install -y git

# Install Oracle JDK 8
RUN wget --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.tar.gz  && \
    mkdir /opt/jdk && \
    tar -zxf jdk-8u66-linux-x64.tar.gz -C /opt/jdk && \
    rm jdk-8u66-linux-x64.tar.gz && \
    update-alternatives --install /usr/bin/java  java  /opt/jdk/jdk1.8.0_66/bin/java 100 && \
    update-alternatives --install /usr/bin/javac javac /opt/jdk/jdk1.8.0_66/bin/javac 100 && \
    update-alternatives --install /usr/bin/jar   jar   /opt/jdk/jdk1.8.0_66/bin/jar 100

# Install maven 3.3.3
RUN wget http://mirrors.sonic.net/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz && \
    tar -zxf apache-maven-3.3.3-bin.tar.gz && \
    mv apache-maven-3.3.3 /usr/local && \
    rm -f apache-maven-3.3.3-bin.tar.gz && \
    ln -s /usr/local/apache-maven-3.3.3/bin/mvn /usr/bin/mvn
    
# Install gradle
ENV GRADLE_VERSION 2.11

WORKDIR /usr/bin
RUN curl -sLO https://downloads.gradle.org/distributions/gradle-2.11-all.zip && \
  unzip gradle-2.11-all.zip && \
  ln -s gradle-2.11 gradle && \
  rm gradle-2.11-all.zip

ENV GRADLE_HOME /usr/bin/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

RUN mkdir /app
WORKDIR /app
