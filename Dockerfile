FROM ruby:3.1.0-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    postgresql-client \
    git \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install rails

WORKDIR /project
COPY Gemfile Gemfile.lock /project/
RUN bundle install

EXPOSE 3000

RUN rm tmp/pids/server.pid

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]