# Meetup Bot

Notifies Slack of Tech Lancaster meetups for the week.  Executed by a cron job 
on Monday mornings.

## Install

```bash
go get github.com/tomswartz07/meetupbot
```

## Usage

```
export API_KEY='GOOGLE CALENDAR API KEY'
export CAL_ID='GOOGLE CALENDAR ID'
export SLACK_WEBHOOK='SLACK WEBHOOK URL'
meetupbot
```

Alternately, a Docker container can be used.

```
docker pull ghcr.io/tomswartz07/meetupbot:latest

docker run --rm -d \
-e API_KEY='GOOGLE CALENDAR API KEY' \
-e CAL_ID='GOOGLE CALENDAR ID' \
-e TZ='America/New_York'
-e SLACK_WEBHOOK='SLACK WEBHOOK URL' \
ghcr.io/tomswartz07/meetupbot:latest
```

The docker image defaults to 10am on Monday, based on the TZ
Timezone env var.
