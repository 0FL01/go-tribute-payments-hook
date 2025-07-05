FROM golang:1.23-alpine AS builder

WORKDIR /src

COPY app/go.mod app/go.sum ./
RUN go mod download

COPY app/ ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /tribute-hook .

FROM alpine:3.22

RUN apk add --no-cache su-exec &&addgroup -g 1001 nonroot && adduser -u 1001 -G nonroot -S -D nonroot

WORKDIR /app

COPY --from=builder /tribute-hook /app/tribute-hook

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER 1001:1001

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD []