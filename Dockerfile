FROM ruby:2.5.8

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get update -yqq \
  && apt-get install -yqq --no-install-recommends \
  gcc g++ make nodejs \
  build-essential \
  libpq-dev \
  curl software-properties-common \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists 

WORKDIR /app

COPY . .

RUN gem install bundler

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

EXPOSE 80

CMD . ./terraform-entrypoint.sh 
