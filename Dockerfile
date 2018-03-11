FROM centos:7

ARG FRP_VERSION=0.16.0

RUN yum update \
	&& yum -y install wget
	
WORKDIR /tmp

RUN set -x \
	&& wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
	&& tar -zxf frp_${FRP_VERSION}_linux_amd64.tar.gz \
	&& mv frp_${FRP_VERSION}_linux_amd64 /var/frp \
	&& mkdir -p /var/frp/conf \
	&& yum remove -y wget \
	&& yum autoremove  -y
	
COPY conf/frps_min.ini /var/frp/conf/frps.ini

VOLUME /var/frp/conf
EXPOSE 80 443 7000 7500

WORKDIR /var/frp
ENTRYPOINT ./frps -c ./conf/frps.ini
	