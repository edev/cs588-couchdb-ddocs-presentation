FROM ruby:2.6.5

ENV APP_HOME /app

WORKDIR $APP_HOME

COPY Gemfile Gemfile.lock ./
RUN bundle install

copy /firstrun.rb .
COPY /ddocs/*.rb ddocs/
COPY /docs/*.rb docs/

CMD ["bundle", "exec", "ruby", "firstrun.rb"]

