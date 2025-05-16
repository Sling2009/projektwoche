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

#Args
ARG APP_VERSION=dev
ARG PORT=8080

#ENvs
ENV PORT=${PORT}

LABEL name="http-app"
LABEL maintainer="axel.fischer@inverso.de"
LABEL app.version="${APP_VERSION}"
LABEL io.k8s.description="Kleine Go HTTP-App für Workshop Docker & Kubernetes"
LABEL io.k8s.display-name="go http-app"

# Kopiere Binary aus Build-Stage
COPY --from=builder /app/http-app /usr/local/bin/http-app

# Port expose (dein Go nutzt Port 8080)
EXPOSE ${PORT}

ENTRYPOINT ["http-app"]

