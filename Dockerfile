FROM ruby:3.1.2

RUN apt install imagemagick
# create working directory
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]