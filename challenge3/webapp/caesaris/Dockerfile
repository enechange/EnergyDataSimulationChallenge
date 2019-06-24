FROM ruby:2.6.1-alpine3.9

RUN set -x && apk update && apk upgrade && apk add --no-cache \
  gnupg gcc g++ make git curl openssh-client bash nodejs-npm yarn tzdata \
  postgresql-dev postgresql-libs postgresql-client

RUN gem install -N bundler

ENV HOME=/usr/src/app
WORKDIR $HOME

ARG ENV
ENV ENV ${ENV}
ARG NODE_ENV
ENV NODE_ENV ${NODE_ENV}
ARG NODE_OPTIONS
ENV NODE_OPTIONS ${NODE_OPTIONS}
ARG VUE_APP_NAME
ENV VUE_APP_NAME ${VUE_APP_NAME}

ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV}
# ARG RAILS_MASTER_KEY
# ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}
ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE ${SECRET_KEY_BASE}
ARG POSTGRES_PASSWORD
ENV POSTGRES_PASSWORD ${POSTGRES_PASSWORD}

ARG DEFAULT_USER_EMAIL
ENV DEFAULT_USER_EMAIL ${DEFAULT_USER_EMAIL}
ARG DEFAULT_USER_PASSWORD
ENV DEFAULT_USER_PASSWORD ${DEFAULT_USER_PASSWORD}
ENV SHOW_DEFAULT_USER ${SHOW_DEFAULT_USER}

ADD Gemfile      $HOME/Gemfile
ADD Gemfile.lock $HOME/Gemfile.lock
RUN bundle install -j4

ADD . $HOME

RUN cd /usr/src/app/vendor/admin && yarn install
RUN bundle exec rake assets:precompile

RUN rm -rf /usr/src/app/vendor/admin

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
