#!/usr/bin/bash

source /etc/profile.d/rvm.sh

for ver in $RUBY_VERSIONS; do
  rvm $ver@global do bundle install
  rvm $ver@global do bundle clean --force
done
