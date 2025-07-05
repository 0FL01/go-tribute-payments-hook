FROM golang:1.23-alpine AS builder

WORKDIR /src

COPY app/go.mod app/go.sum ./
RUN go mod download

COPY app/ ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -o /tribute-hook .

FROM gcr.io/distroless/static-debian12

WORKDIR /app

COPY --from=builder /tribute-hook /app/tribute-hook

USER nonroot:nonroot

CMD ["/app/tribute-hook"]