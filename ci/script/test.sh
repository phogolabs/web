#!/usr/bin/env sh

cd web

bundle install
bundle exec rake spec
