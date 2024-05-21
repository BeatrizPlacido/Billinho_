FROM ruby:3.0.2

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /application

COPY Gemfile /application/Gemfile
COPY Gemfile.lock /application/Gemfile.lock

RUN bundle install
RUN bundle update --bundler

COPY . /application

CMD 'rails server -b 0.0.0.0'
