#FROM openjdk:8-jdk-alpine
FROM centos:7
MAINTAINER Karol Stuart "karolstuart@yahoo.com"

RUN yum -y update; yum clean all
RUN yum -y install openssl wget 

RUN mkdir  -p  /opt/software/scripts/getmac/ssh
RUN cd /opt/software/scripts/getmac

#TOOL1 GETMAC
COPY ./call_macaddress_io.sh /opt/software/scripts/getmac/
copy ./help.txt /opt/software/scripts/getmac/

CMD echo "Running getmac utility....."
ENV PATH /opt/software/scripts/getmac:$PATH
ENTRYPOINT ["call_macaddress_io.sh"]



