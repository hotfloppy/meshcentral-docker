# Filename: Dockerfile

FROM node:lts-stretch-slim
#FROM ubuntu:latest

# Disable Prompt During Packages Installation
ARG DEBIAN_FRONTEND=noninteractive

# install dependencies and set capabilities limit
RUN apt-get update \
  && apt-get install -y gnupg vim wget \
  && wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - \
  && echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.4 main" > /etc/apt/sources.list.d/mongodb-org-4.4.list \
  && apt-get update \
  && apt-get install -y mongodb-org-tools
  # && setcap cap_net_bind_service=+ep /usr/local/bin/node

#Add non-root user, add installation directories and assign proper permissions
RUN mkdir -p /opt/meshcentral

#meshcentral installation
WORKDIR /opt/meshcentral

RUN npm install meshcentral

EXPOSE 80 443 8181 4333

#volumes
VOLUME /opt/meshcentral/meshcentral-data
VOLUME /opt/meshcentral/meshcentral-files

CMD [ "node", "./node_modules/meshcentral" ]
