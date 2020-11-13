#!/usr/bin/bash

source /etc/profile.d/rvm.sh
echo 'gem: --no-document' > ~/.gemrc

for ver in $RUBY_VERSIONS; do
  rvm $ver@global

  gem update bundler
  gem update --system
  bundle install
  bundle clean --force
done

set -euo pipefail

for ver in $RUBY_VERSIONS; do
  SHORT_VER=${ver%.*}
  mkdir -p /tmp/cache/$SHORT_VER
  cp -r /usr/local/rvm/rubies/ruby-$ver/lib/ruby/gems/$SHORT_VER.0/* /tmp/cache/$SHORT_VER/
done
