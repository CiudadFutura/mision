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

# Usuario y grupo por defecto
ARG USERID=1000
ARG GROUPID=1000
#RUN echo "--------------> ${GROUPID} ${USERID}"
RUN addgroup -g ${GROUPID}  "mai" \
    && adduser \
    --disabled-password \
    --gecos "Mision" \
    --ingroup "mai" \
    --uid "${USERID}" \
    "mai"

LABEL maintainer="Ciudad Futura" \
      description="Contenedor para desarrollo de la mision" \
      version="1.0"

WORKDIR /app
RUN chown mai:mai -R /app
USER mai
RUN gem install bundler -v ${BUNDLER_VERSION}
RUN gem install pkg-config -v "~> 1.1"

COPY --chown=${USERID}:${GROUPID} Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle install
VOLUME [ "/app" ]

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0","-e", "development"]
