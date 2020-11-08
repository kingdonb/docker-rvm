#!/usr/bin/bash

source /etc/profile.d/rvm.sh
echo 'gem: --no-document' > ~/.gemrc

for ver in $RUBY_VERSIONS; do
  rvm $ver@global do gem update bundler
  rvm $ver@global do gem update --system
  rvm $ver@global do bundle install
  rvm $ver@global do bundle clean --force

done

for ver in $RUBY_VERSIONS; do
  SHORT_VER=${ver%.*}
  mkdir -p /tmp/cache/$SHORT_VER
  cp -r /usr/local/rvm/rubies/ruby-$ver/lib/ruby/gems/$SHORT_VER.0/* /tmp/cache/$SHORT_VER/
done
