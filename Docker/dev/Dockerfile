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
      #required for mysql2
      mariadb-dev \
      #required for libv8
      python2 \
      binutils-gold \
      build-base \
      curl \
      file \
      g++ \
      gcc \
      git \
      less \
      libstdc++ \
      libffi-dev \
      libc-dev \ 
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      libgcrypt-dev \
      make \
      netcat-openbsd \
      nodejs \
      openssl \
      pkgconfig \
      tzdata \
      #Borrame solo develop
      sqlite-dev \
      yarn 
      # Porque necesitasmos yarn y NPM??
      #npm

RUN gem install bundler -v 2.1.4
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install
#COPY package.json yarn.lock ./
#RUN yarn install --check-files
#RUN npm install
VOLUME [ "/app" ]

ENV APPVER=3
COPY Docker/dev/entrypoints/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0","-e", "development"]

#RUN RAILS_ENV=production rake assets:precompile
#RUN RAILS_ENV=production RACK_ENV=production NODE_ENV=production bin/webpack