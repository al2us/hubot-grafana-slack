FROM alpine

# If you want to upload grafana screeshoots in AWS S3 then install AWS CLI (uncomment line below)
#ENV AWSCLI_VERSION "1.17.0"

# Dependencies
RUN apk update && apk upgrade \
  && apk add redis \
 # If you want to upload grafana screeshoots in AWS S3 then install AWS CLI. (You must set environments as secret key, accesskey, bucket, prefix)
 # Uncomment lines below
  #&& apk add python3 \
  #&& apk add python3-dev \
  #&& apk add py-pip \
  #&& apk add build-base \
  #&& pip install awscli==$AWSCLI_VERSION --upgrade --user \
  && apk add --update nodejs nodejs-npm \
  && apk add curl \
  && npm install -g npm \
  && npm install -g coffee-script \
  && npm install -g yo generator-hubot \
  && apk --purge -v del py-pip \
  && rm -rf /var/cache/apk/*

# Create hubot user
RUN adduser -h /hubot -s /bin/bash -S hubot
USER  hubot
WORKDIR /hubot

# Set Environments
ENV HUBOT_SLACK_TOKEN=Insert_Token_here
ENV HUBOT_GRAFANA_HOST=Insert_grafana_host_here 
ENV HUBOT_GRAFANA_API_KEY=Insert_apikey_here
# Install hubot
RUN yo hubot --owner="aldo.hruiz@outlook.com" --name="jarvis" --description="I'm jarvis" --defaults
COPY package.json package.json
RUN npm install
ADD hubot/external-scripts.json /hubot/

# Overwriting start(this script is fixed by https://github.com/noqcks/alpine-hubot/issues/2)
ADD bin/hubot bin/ 
EXPOSE 8080

# And go
ENTRYPOINT ["/bin/sh", "-c", "bin/hubot --adapter slack"]
