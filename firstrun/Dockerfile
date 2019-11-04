FROM ruby:2.6.5

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY docs docs
COPY ddocs ddocs
COPY *.rb *.erb ./

CMD ["bundle", "exec", "ruby", "firstrun.rb"]

