FROM golang:1.17-alpine AS build

WORKDIR /workdir/
COPY . /workdir/
RUN CGO_ENABLED=0 go build -o /bin/meetupbot

FROM alpine:3.15.0
COPY --from=build /bin/meetupbot /bin/meetupbot
COPY cron .
RUN crontab cron
CMD [ "crond", "-f" ]
