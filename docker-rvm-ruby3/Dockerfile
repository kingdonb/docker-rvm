# syntax = docker/dockerfile:experimental
FROM kingdonb/docker-rvm-support:20210223-ruby3
LABEL maintainer="Kingdon Barrett <kingdon.b@nd.edu>"
ENV APPDIR="/home/${RVM_USER}/app"

# include the ruby-version and Gemfile for bundle install
ADD Gemfile Gemfile.lock ${APPDIR}/
ADD jenkins/bundle-install-all-versions.sh ${APPDIR}/jenkins/

ENV RUBY_VERSIONS="3.0.0"

RUN --mount=type=cache,uid=999,gid=1000,target=/usr/local/rvm/rubies/ruby-3.0.0/lib/ruby/gems/3.0.0 \
    --mount=type=ssh,uid=999,gid=1000 \
    ${APPDIR}/jenkins/bundle-install-all-versions.sh
RUN  rm -r /usr/local/rvm/rubies/ruby-3.0.0/lib/ruby/gems/3.0.0/* \
  && cp -r /tmp/cache/3.0/* /usr/local/rvm/rubies/ruby-3.0.0/lib/ruby/gems/3.0.0/ \
  && rm -r /tmp/cache # \
#  && rm -r /usr/local/rvm/rubies/ruby-3.0.0/lib/ruby/gems/3.0.0/bundler/gems/rails-a1d35aecc6e2
