FROM ruby:2.6.5

ENV APP_HOME /app

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock app.rb ./

RUN bundle install

EXPOSE 4567 4567

CMD ["bundle", "exec", "ruby", "app.rb"]
# CMD "./app.rb"
