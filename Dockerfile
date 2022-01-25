FROM ruby:2.7.5

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY . /myapp
