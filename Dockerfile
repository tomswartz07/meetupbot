FROM golang:1.23.5-alpine AS build

WORKDIR /workdir/
COPY . /workdir/
RUN apk add --update tzdata
RUN CGO_ENABLED=0 go build -buildvcs=false -o /bin/meetupbot

FROM alpine:3.21.2
LABEL org.opencontainers.image.source https://github.com/tomswartz07/meetupbot
LABEL org.opencontainers.image.authors="tom+docker@tswartz.net"
LABEL description="Docker container to run a Slack bot which posts weekly \
meetup reminders obtained from public calendars."
LABEL org.opencontainers.image.description="Docker container to run a Slack bot \
which posts weekly meetup reminders obtained from public calendars."
COPY --from=build /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=build /bin/meetupbot /bin/meetupbot
ENV TZ=America/New_York
COPY cron .
RUN crontab cron
CMD [ "crond", "-f" ]
HEALTHCHECK CMD ps aux | grep '[c]ron' || exit 1
