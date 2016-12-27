FROM ruby:2.3
MAINTAINER "Phogo Labs <engineering@phogolabs.com>"

ENV LC_ALL C.UTF-8

RUN mkdir -p /var/app/vendor
COPY . /var/app/

WORKDIR /var/app

RUN gem install bundler
RUN bundle install

EXPOSE 9292
