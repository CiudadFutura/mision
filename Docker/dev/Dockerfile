FROM ruby:2.7-alpine
ENV BUNDLER_VERSION=2.1.4
RUN apk add --update --no-cache \
      # Add CA for TLS
      ca-certificates \
      # image
      imagemagick-dev \
      #required for bundle install
      git \
      #required for nokogiri
      build-base \ 
      libxml2-dev \
      libxslt-dev \
      #required for mysql2
      mariadb-dev \
      # tzinfo-data
      tzdata \
      #Borrame solo develop
      #sqlite-dev \
      # Webpack
      nodejs \
      yarn \
      # Solo la usamos para esperar la DB
      netcat-openbsd 

      # pkgconfig \
      # binutils-gold \
      # curl \
      # file \
      # g++ \
      # gcc \
      # git \
      # less \
      # libstdc++ \
      # libffi-dev \
      # libc-dev \ 
      # linux-headers \
      # libgcrypt-dev \
      # make \
      # openssl \

RUN gem install bundler -v ${BUNDLER_VERSION}
RUN gem install pkg-config -v "~> 1.1"
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install
VOLUME [ "/app" ]

COPY Docker/dev/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0","-e", "development"]
