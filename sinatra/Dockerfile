FROM ruby:2.6.5

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY docs docs
COPY ddocs ddocs
COPY *.rb *.erb ./
COPY public public

EXPOSE 4567 4567

CMD ["bundle", "exec", "ruby", "app.rb"]
# CMD "./app.rb"
