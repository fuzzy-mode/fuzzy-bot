FROM ruby:2.4.1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app
COPY Gemfile.lock /usr/src/app
RUN bundle install

COPY Procfile /usr/src/app
COPY config.ru /usr/src/app
COPY slack-fuzzybot.rb /usr/src/app
COPY slack-fuzzybot /usr/src/app/slack-fuzzybot
COPY web.rb /usr/src/app

CMD ["bundle", "exec", "foreman", "start"]

EXPOSE 5000
