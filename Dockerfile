FROM ubuntu:20.04 as Builder

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Argentina/Buenos_Aires
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

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
    && apt-get clean

# && apt-get purge -yqq node-* || true \
#    && apt-get -yqq autoremove \
RUN useradd -ms /bin/bash unprivilegedUser

WORKDIR /home/unprivilegedUser/app
RUN chown unprivilegedUser:unprivilegedUser .

USER unprivilegedUser

# Install RVM, Ruby y gemas basicas
RUN gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby="2.7.1" --with-default-gems="bundler:2.1.4 pkg-config"

# Entry Ponit
COPY Docker/docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

# Install Deps (Gemas and Webpack)
COPY --chown=unprivilegedUser:unprivilegedUser Gemfile Gemfile.lock yarn.lock package.json ./

RUN ~/.rvm/gems/ruby-2.7.1/wrappers/bundle install
RUN yarn install
RUN npm install

EXPOSE 3000

# Copy Mai
COPY --chown=unprivilegedUser:unprivilegedUser . .

VOLUME [ "/home/unprivilegedUser/app" ]
VOLUME [ "/home/unprivilegedUser/app/log" ]

CMD ["rails", "server", "-b", "0.0.0.0"]

#FROM ruby:2.7
#WORKDIR /app
#ADD . /app/
#RUN set -uex; \
#    bundle install; \
#    adduser -D rubyapp; \
#    mkdir -p /app/data; \
#    chown rubyapp /app/data
#USER rubyapp
#CMD [ "ruby", "whatever.rb" ]

# FROM ruby:2.7.2-alpine
# RUN apk add 
# # throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1
# WORKDIR /usr/src/app
# COPY Gemfile Gemfile.lock ./
# RUN bundle install
# COPY . .
# CMD ["rails", "server", "-b", "0.0.0.0"]