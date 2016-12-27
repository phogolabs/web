FROM ruby:2.3
MAINTAINER "Phogo Labs <engineering@phogolabs.com>"

ENV LC_ALL C.UTF-8

RUN mkdir -p /var/app/vendor
COPY . /var/app/

WORKDIR /var/app
RUN bundle install --local -j $(nproc)

EXPOSE 9292

CMD [ "bundle", "exec", "rackup"]
