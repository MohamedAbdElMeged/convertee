FROM ruby:3.1.2-alpine

WORKDIR /app
RUN apk add --no-cache \
build-base \
mysql-dev \
tzdata \
imagemagick \
git \
linux-headers \
gcompat \
libstdc++ \
bash





COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

COPY . .


CMD ["rails", "server", "-b", "0.0.0.0"]