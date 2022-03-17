FROM golang:1.18.0-alpine AS build

WORKDIR /workdir/
COPY . /workdir/
RUN CGO_ENABLED=0 go build -buildvcs=false -o /bin/meetupbot

FROM alpine:3.15.1
LABEL org.opencontainers.image.source https://github.com/tomswartz07/meetupbot
LABEL org.opencontainers.image.authors="tom+docker@tswartz.net"
LABEL description="Docker container to run a Slack bot which posts weekly \
meetup reminders obtained from public calendars."
LABEL org.opencontainers.image.description="Docker container to run a Slack bot \
which posts weekly meetup reminders obtained from public calendars."
COPY --from=build /bin/meetupbot /bin/meetupbot
COPY cron .
RUN crontab cron
CMD [ "crond", "-f" ]
