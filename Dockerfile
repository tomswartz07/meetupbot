FROM golang:1.17-alpine AS build

WORKDIR /workdir/
COPY . /workdir/
RUN CGO_ENABLED=0 go build -o /bin/meetupbot

FROM scratch
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=build /bin/meetupbot /bin/meetupbot
CMD ["/bin/meetupbot"]
