FROM ubuntu:20.04 as Builder

EXPOSE 3000

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Argentina/Buenos_Aires
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# RUN apk add 
RUN apt-get update && \
    apt-get install -y --no-install-recommends pkg-config libxml2 libxml2-dev libui-gxmlcpp-dev build-essential patch ruby-dev zlib1g-dev liblzma-dev default-libmysqlclient-dev libreadline6-dev libreadline-dev npm \
    # Download
    curl ca-certificates  \
    # RVM deps
    # gtar && \
    # Git
    git \
    # PPA
    software-properties-common \
    # Clean
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

#Add RVM Repo
RUN apt-add-repository -y ppa:rael-gc/rvm \ 
    && apt-get update \
    && apt-get install -y rvm \
    && apt-get -o Dpkg::Options::="--force-confold" upgrade -q -y --force-yes \
    && apt-get -o Dpkg::Options::="--force-confold" dist-upgrade -q -y --force-yes \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

#Add Yarn Repo
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends yarn \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

RUN /bin/bash -c "/usr/share/rvm/bin/rvm install ruby-2.7.1"
RUN /bin/bash -c "/usr/share/rvm/bin/rvm use ruby-2.7.1"

RUN gem install bundler:2.1.4
RUN gem install pkg-config -v "~> 1.1"

WORKDIR /app

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

COPY Gemfile Gemfile.lock yarn.lock package.json package-lock.json ./

RUN bundle install
RUN yarn install
RUN npm install

COPY . .

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["rails", "server", "-b", "0.0.0.0"]


# FROM ruby:2.7.2-alpine
# RUN apk add 
# # throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1
# WORKDIR /usr/src/app
# COPY Gemfile Gemfile.lock ./
# RUN bundle install
# COPY . .
# CMD ["rails", "server", "-b", "0.0.0.0"]