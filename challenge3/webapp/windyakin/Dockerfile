FROM ruby:2.6.2

WORKDIR /usr/src/app

ADD Gemfile .
ADD Gemfile.lock .

RUN gem install bundler \
  && bundle install -j4

ADD . .

ENTRYPOINT ["bundle", "exec"]
CMD ["rails", "s", "-p", "3000", "-b", "0.0.0.0"]
