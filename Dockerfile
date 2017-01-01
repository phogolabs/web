FROM phogo/ruby
MAINTAINER "Phogo Labs <engineering@phogolabs.com>"

ENV LC_ALL C.UTF-8

RUN mkdir -p /var/app/vendor
COPY . /var/app/

WORKDIR /var/app

RUN bundle install

RUN rm -fr infrastructure
RUN rm -fr Dockerfile

EXPOSE 9292
