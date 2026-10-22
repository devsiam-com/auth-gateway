FROM golang:1.27-alpine AS builder

RUN apk add --no-cache git gcc musl-dev sqlite-dev

WORKDIR /app
RUN git clone --branch v2.46.0 --depth 1 https://github.com/dexidp/dex .

RUN go mod download

# Patch vulnerable deps while keeping everything else locked
RUN go get golang.org/x/net@v0.60.0 && \
    go mod tidy

RUN CGO_ENABLED=1 GOFLAGS="-trimpath" go build -o /app/dex ./cmd/dex

# runtime
FROM alpine:3.23

# apk upgrade pulls the patched zlib (>= 1.3.2, CVE-2026-22184) from the stable repo
RUN apk upgrade --no-cache && \
    apk add --no-cache sqlite-libs && \
    adduser -D -u 1001 dex && \
    mkdir -p /var/dex && chown dex:dex /var/dex

COPY --from=builder /app/dex /usr/local/bin/dex

USER dex
ENTRYPOINT ["dex"]
