FROM ruby:2.6.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-client

# Set an environment variable where the Rails app is installed to inside of Docker image
ENV RAILS_ROOT /var/www/rails/
RUN mkdir -p $RAILS_ROOT

# Set working directory
WORKDIR $RAILS_ROOT

# Adding project files
COPY . .

# Install Gemfile Dependencies
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
