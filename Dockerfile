FROM ruby:2.3
MAINTAINER "Phogo Labs <engineering@phogolabs.com>"

ENV LC_ALL C.UTF-8

RUN mkdir -p /var/app/vendor
COPY . /var/app/
RUN bundle install --local -j $(nproc)

EXPOSE 9292

WORKDIR /var/app

CMD [ "bundle", "exec", "rackup"]
