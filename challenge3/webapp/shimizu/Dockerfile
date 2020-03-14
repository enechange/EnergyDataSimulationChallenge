FROM ruby:2.7.0
ENV LANG C.UTF-8
ENV DEBCONF_NOWARNINGS yes
ENV YARN_VERSION 1.22.4
ENV APP_ROOT /usr/src/app
RUN apt-get update -qq && \
    apt-get install -y vim nodejs \
                       mariadb-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/* /tmp/* /var/tmp/*
WORKDIR $APP_ROOT
COPY Gemfile Gemfile.lock $APP_ROOT/

RUN curl -L --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" > /tmp/yarn.tar.gz && \
  tar -xzf /tmp/yarn.tar.gz -C /opt && \
  ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn && \
  ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg && \
  rm /tmp/yarn.tar.gz

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem
COPY . $APP_ROOT

CMD ["rails", "server", "-b", "0.0.0.0"]
