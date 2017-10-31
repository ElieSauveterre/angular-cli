FROM ubuntu:16.10

MAINTAINER Elie <contact [at] eliesauveterre [dot] com>

ENV NODEJS_VERSION=6.9.5 \
	NPM_VERSION=3.10.10 \
	ANGULAR_CLI_VERSION=1.1.0 \
	PATH=$PATH:/opt/node/bin

# Install nodejs	& requirements

WORKDIR "/opt/node"

RUN apt-get update && apt-get install -y curl ca-certificates git wget unzip libfontconfig bzip2 \
    gcc make g++ ruby rubygems ruby-dev ruby-all-dev --no-install-recommends && \
    curl -sL https://nodejs.org/dist/v${NODEJS_VERSION}/node-v${NODEJS_VERSION}-linux-x64.tar.gz | tar xz --strip-components=1

# Instal npm packages
RUN	npm i -g --unsafe-perm npm@${NPM_VERSION} @angular/cli@${ANGULAR_CLI_VERSION}

# Install typings
RUN npm install -g typings

# Install Sass
RUN gem install sass

### Clean
RUN apt-get -y autoclean
RUN apt-get -y clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/*

WORKDIR "/app"

EXPOSE 8100 35729
