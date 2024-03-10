FROM ubuntu:22.04

ARG HOSTNAME
ARG DOMAINNAME

ENV HOSTNAME $HOSTNAME
ENV DOMAINNAME $DOMAINNAME

ENV TZ=Asia/Bangkok
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update

RUN apt -y install postfix mailutils opendkim opendkim-tools 
RUN apt -y install locales idn tzdata rsyslog

RUN sed -i '/th_TH.UTF-8/s/^# //g' /etc/locale.gen && \
	locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=th_TH.UTF-8
ENV LANGUAGE=th_TH.UTF-8
ENV LC_ALL=th_TH.UTF-8

# opendkim# opendkim# opendkim
RUN usermod -G opendkim postfix
COPY opendkim.conf /etc/opendkim.conf
COPY etc-opendkim/ /etc/opendkim/
COPY etc-default/opendkim /etc/default/opendkim

RUN mkdir /var/spool/postfix/opendkim
RUN chown opendkim:postfix /var/spool/postfix/opendkim

COPY app-run.sh /opt/run.sh
ENTRYPOINT ["/bin/bash", "/opt/run.sh"]
