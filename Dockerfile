FROM golang:1.17-alpine AS build

WORKDIR /workdir/
COPY . /workdir/
RUN CGO_ENABLED=0 go build -o /bin/meetupbot

FROM alpine:3.15.0
LABEL org.opencontainers.image.source https://github.com/tomswartz07/meetupbot
LABEL org.opencontainers.image.authors="tom+docker@tswartz.net"
LABEL description="Docker container to run a Slack bot which posts weekly \
meetup reminders obtained from public calendars."
COPY --from=build /bin/meetupbot /bin/meetupbot
COPY cron .
RUN crontab cron
CMD [ "crond", "-f" ]
