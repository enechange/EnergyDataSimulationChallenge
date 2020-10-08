FROM ruby:2.7.1-alpine3.12


ENV DOCKERIZE_VERSION=v0.6.1

WORKDIR /challenge3

COPY Gemfile /challenge3/Gemfile
COPY Gemfile.lock /challenge3/Gemfile.lock

RUN apk update && \
    apk add --no-cache \
    linux-headers \
    libxml2 libxslt  curl-dev make gcc libc-dev g++ \
    nodejs \
    mariadb-dev \
    tzdata \
    openssl \
    yarn && \
    yarn add chartkick chart.js && \
    wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENV BUNDLER_VERSION=2.1.4

RUN gem install bundler && \
    bundle install --without development test && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    rm -rf /usr/local/bundle/ruby/2.7.1/cache/* && \
    rm -rf /root/.bundle/cache/* && \
    find /usr/lib/node_modules -delete && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete && \
    apk del --purge libxml2-dev curl-dev make gcc libc-dev g++ linux-headers && \
    rails assets:precompile RAILS_ENV=production
COPY . /challenge3
