# Step 1: Build stage
FROM golang:1.24.3 AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o gatorfeed .

# Step 2: Runtime stage
FROM alpine:latest
RUN apk add --no-cache ca-certificates

WORKDIR /root/
COPY --from=builder /app/gatorfeed .

ENV DB_URL=""
ENTRYPOINT ["./gatorfeed"]
