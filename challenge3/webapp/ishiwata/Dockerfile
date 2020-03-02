
FROM ruby:2.5.3

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get update && \
    apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install nodejs

RUN yarn add node-sass

RUN yarn add vue-chartjs chart.js
RUN yarn add add axios


RUN mkdir /challenge3
ENV APP_ROOT /challenge3
WORKDIR $APP_ROOT
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN gem install bundler
RUN bundle install

ADD . $APP_ROOT
