FROM ubuntu:20.04 as Builder

ENV RUBY_VER=2.7.1
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Argentina/Buenos_Aires
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 3000

# Install Deps (Gemas and Webpack)
WORKDIR /app
COPY Gemfile Gemfile.lock yarn.lock package.json ./

# RUN apk add 
RUN apt-get update && \
    apt-get install -y --no-install-recommends pkg-config libxml2 libxml2-dev libui-gxmlcpp-dev build-essential patch ruby-dev zlib1g-dev liblzma-dev default-libmysqlclient-dev libreadline6-dev libreadline-dev \ 
    # Webpack
    npm \ 
    # image handler
    imagemagick \
    # Download
    curl ca-certificates  \
    # RVM deps
    gawk bison libffi-dev libgdbm-dev libncurses5-dev libsqlite3-dev libtool libyaml-dev sqlite3 \
    # Git
    git \
    # PPA
    software-properties-common \
    gnupg2 \
    # Update All System
    && apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes \
    && apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y --force-yes \
    # Add Yarn Repo
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends yarn \
    # Clean
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean \
    && useradd -ms /bin/bash unprivilegedUser \
    && su - unprivilegedUser -c "gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB" \
    && su - unprivilegedUser -c "curl -sSL https://get.rvm.io | bash -s stable --ruby="${RUBY_VER}" --with-default-gems=\"bundler:2.1.4 pkg-config\"" \
    && su - unprivilegedUser -c "mkdir /home/unprivilegedUser/app" \
    && chown -R unprivilegedUser:unprivilegedUser /app  \
    && su - unprivilegedUser -c "mv -f /app/* /home/unprivilegedUser/app" \
    && cd \
    && su - unprivilegedUser -c "export PATH=~/.rvm/scripts/extras/rails:~/.rvm/gems/ruby-${RUBY_VER}/wrappers:$PATH" \
    && su - unprivilegedUser -c "cd app && ~/.rvm/gems/ruby-${RUBY_VER}/wrappers/bundle config set without 'development test' " \
    && su - unprivilegedUser -c "cd app && ~/.rvm/gems/ruby-${RUBY_VER}/wrappers/bundle install" \
    && su - unprivilegedUser -c "cd app && yarn install && yarn autoclean --force" \
    && su - unprivilegedUser -c "cd app && npm set progress=false && npm config set depth 0 && npm install --only=production " \
#    && su - unprivilegedUser -c "" \
    && apt-get remove -y --purge git build-essential yarn npm  \
    && apt autoremove -y \
    && apt-get clean \
    && apt-get autoclean

# Entry Ponit
COPY Docker/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

USER unprivilegedUser

# Copy Mai
COPY --chown=unprivilegedUser:unprivilegedUser . .

# Punto de montaje de los uploads
VOLUME [ "/home/unprivilegedUser/app/public/uploads" ]
# Punto de montaje de los logs
VOLUME [ "/home/unprivilegedUser/app/log" ]

CMD ["rails", "server", "-b", "0.0.0.0"]



# FROM ruby:2.7-alpine
# WORKDIR /app
# ENV RUBY_VER=2.7.1
# VOLUME [ "/app/public/uploads" ]
# VOLUME [ "/app/log" ]
# RUN apk --no-cache add \
#     # Add CA for TLS
#     ca-certificates \
#     # image
#     imagemagick-dev \
#     #required for bundle install
#     git \
#     #required for nokogiri
#     build-base \ 
#     #required for mysql2
#     mariadb-dev \
#     #required for libv8
#     python2
# RUN adduser -D rubyapp \
#     && chown rubyapp .

# USER rubyapp

# # https://github.com/rubyjs/libv8#use-with-different-standard-c-libraries
# RUN git clone --recursive git://github.com/rubyjs/libv8.git && cd libv8 && bundle install &&  bundle exec rake compile && cd ..

# ENV PATH=~/.rvm/scripts/extras/rails:~/.rvm/gems/ruby-${RUBY_VER}/wrappers:$PATH
# COPY --from=Builder /home/unprivilegedUser/app .
# RUN bundle config set without 'development test'
# RUN bundle install

# USER root
# # Limpiamos 
# # Eliminamos lo que se usa con bundle
# RUN apk del git build-base

# USER rubyapp
# CMD ["rails", "server", "-b", "0.0.0.0"]

