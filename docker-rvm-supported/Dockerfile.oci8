# syntax = docker/dockerfile:experimental
FROM kingdonb/docker-rvm-support:20210819
LABEL maintainer="Kingdon Barrett <kingdon.b@nd.edu>"
ENV APPDIR="/home/${RVM_USER}/app"

# include the ruby-version and Gemfile for bundle install
ADD Gemfile Gemfile.lock ${APPDIR}/
ADD jenkins/bundle-install-all-versions.sh ${APPDIR}/jenkins/

ENV RUBY_VERSIONS="2.7.4 2.6.8 3.0.2"

ENV LD_LIBRARY_PATH /opt/oracle/instantclient_19_8
ENV TNS_ADMIN /etc/oracle
RUN --mount=type=cache,uid=999,gid=1000,target=/usr/local/rvm/rubies/ruby-2.6.8/lib/ruby/gems/2.6.0 \
    --mount=type=cache,uid=999,gid=1000,target=/usr/local/rvm/rubies/ruby-2.7.4/lib/ruby/gems/2.7.0 \
    --mount=type=cache,uid=999,gid=1000,target=/usr/local/rvm/rubies/ruby-3.0.2/lib/ruby/gems/3.0.0 \
    --mount=type=ssh,uid=999,gid=1000 \
    ${APPDIR}/jenkins/bundle-install-all-versions.sh
RUN  rm -r /usr/local/rvm/rubies/ruby-2.6.8/lib/ruby/gems/2.6.0/* \
  && cp -r /tmp/cache/2.6/* /usr/local/rvm/rubies/ruby-2.6.8/lib/ruby/gems/2.6.0/ \
  && rm -r /usr/local/rvm/rubies/ruby-2.7.4/lib/ruby/gems/2.7.0/* \
  && cp -r /tmp/cache/2.7/* /usr/local/rvm/rubies/ruby-2.7.4/lib/ruby/gems/2.7.0/ \
  && rm -r /usr/local/rvm/rubies/ruby-3.0.2/lib/ruby/gems/3.0.0/* \
  && cp -r /tmp/cache/3.0/* /usr/local/rvm/rubies/ruby-3.0.2/lib/ruby/gems/3.0.0/
