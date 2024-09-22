FROM ruby:3.1.4-bullseye

RUN apt-get update -qq

ENV EDITOR="vim"

RUN apt-get -y install vim cron

RUN gem install rails -v 7.1.3.2

WORKDIR /app

COPY /bot/Gemfile /bot/Gemfile.lock ./

RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0", "-p", "5000"]