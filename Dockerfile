FROM node:4.2.2 

MAINTAINER Zane McCaig

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Install universal tools
RUN apt-get install -y git make g++
RUN npm install -g https://github.com/zanemcca/node-mongodb-s3-backup.git
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.4 main" | tee /etc/apt/sources.list.d/mongodb-org-3.4.list
RUN apt-get update
RUN apt-get install mongodb-org-tools

# Copy backup configuration file
COPY backup.config.json /usr/src/app/

# Run the application
CMD /usr/local/bin/mongodb_s3_backup -r backup.config.json
