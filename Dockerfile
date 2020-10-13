FROM ruby:2.7-alpine as base
ENV BUNDLER_VERSION=2.1.4 RAILS_ENV=production RACK_ENV=production NODE_ENV=production
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
      # rails-could-not-find-a-javascript-runtime
      nodejs 
RUN gem install bundler -v ${BUNDLER_VERSION}
RUN gem install pkg-config -v "~> 1.1"
RUN bundle config set without 'development test'
RUN bundle config build.nokogiri --use-system-libraries
WORKDIR /app
COPY . .
RUN bundle check || bundle install

FROM base as builder
RUN apk add --update --no-cache \
      # Webpack
      yarn
WORKDIR /app
RUN yarn install --ignore-engines --check-files --production
#RUN rake assets:precompile
RUN bin/webpack

FROM base
RUN apk add --update --no-cache \
      # Solo la usamos para esperar la DB
      netcat-openbsd 
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/public ./public
RUN bundle check || bundle install

RUN mv docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# Punto de montaje de los uploads
VOLUME [ "/app/public/uploads" ]

CMD ["rails", "server", "-b", "0.0.0.0","-e", "production"]
