FROM phogo/ci
MAINTAINER "Phogo Labs <engineering@phogolabs.com>"

ENV LC_ALL C.UTF-8

RUN mkdir -p /var/app/vendor
COPY . /var/app/

WORKDIR /var/app

EXPOSE 9292
