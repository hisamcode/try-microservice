# base go image

# FROM golang:1.21-alpine as builder

# RUN mkdir /app

# COPY . /app

# WORKDIR /app

# RUN CGO_ENABLED=0 go build -o brokerApp ./cmd/api

# RUN chmod +x /app/brokerApp

# build a tiny docker image
FROM alpine:3.18.3

RUN mkdir /app

# COPY --from=builder /app/brokerApp /app
COPY ./brokerApp /app

CMD ["/app/brokerApp"]

