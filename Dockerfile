FROM     ubuntu:17.10

MAINTAINER Elie <contact [at] eliesauveterre [dot] com>

ENV NODEJS_VERSION=6.9.5 \
	NPM_VERSION=3.10.10 \
	ANGULAR_CLI_VERSION=1.2.0 \
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
RUN apt-get install -y ruby-full rubygems ruby-dev libffi-dev
RUN gem install sass

# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn

### Clean
RUN apt-get -y autoclean
RUN apt-get -y clean
RUN apt-get -y autoremove
RUN rm -rf /var/lib/apt/lists/*

WORKDIR "/app"

EXPOSE 4200 35729
