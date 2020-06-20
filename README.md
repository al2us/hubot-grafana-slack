# hubot

Hubot on alpine, Used to slack, grafana and hubot integration

Requeriments:

-First, you need add hubot app in slack.

-Generate token slack inside config hubot

-Generate api key inside config hubot

- API KEY must be set on APIKEYS grafana section, this action will be return a token that you need to set on docker file ENV API KEY Section


##########################################

Run Docker:

- Set Token, grafana url and API in Dockerfile ENV section
- Build image:

    docker build -t <name> .

- Run Image:

    docker run <name> -d

#############################################

Details:

- If you need storage grafana snapshots in S3, you need to install aws cli and set variables:


    - HUBOT_GRAFANA_S3_BUCKET=mybucket

    
    - HUBOT_GRAFANA_S3_ACCESS_KEY_ID=yyyyyyyy123456XYZ

    
    - HUBOT_GRAFANA_S3_SECRET_ACCESS_KEY=aBcyyyyyyyyyyyyyyyyyyyyy

    
    - HUBOT_GRAFANA_S3_PREFIX=graphs

    
    - HUBOT_GRAFANA_S3_REGION=us-standard


- Your grafana need render image plugin

- If you want see logs, set environment: HUBOT_LOG_LEVEL=debug


