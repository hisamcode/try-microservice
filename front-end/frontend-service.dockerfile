FROM alpine:3.18.3

RUN mkdir /app

COPY ./frontApp /app

CMD ["/app/frontApp"]

