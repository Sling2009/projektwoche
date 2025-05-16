# --- Build-Stage ---
FROM golang:1.24 AS builder

# Build args
ARG APP_VERSION=dev

WORKDIR /app

COPY go/ .

# Binary bauen mit eingebetteten Versionen via ldflags
RUN go build -ldflags "-X 'main.appVersion=${APP_VERSION}'" -o http-app .

# --- Final-Stage ---
FROM redhat/ubi9-micro:9.6

LABEL maintainer="axel.fischer@inverso.de"
LABEL version="1.0.0"
LABEL description="Kleine Go HTTP-App für Workshop Docker & Kubernetes"
LABEL app.version="${APP_VERSION}"

# ENVs
ARG PORT=8080
ENV PORT=${PORT}

# Kopiere Binary aus Build-Stage
COPY --from=builder /app/http-app /usr/local/bin/http-app

# Port expose (dein Go nutzt Port 8080)
EXPOSE ${PORT}

ENTRYPOINT ["http-app"]

