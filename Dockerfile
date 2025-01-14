# Start with the official Golang image as the build environment
FROM golang:1.20-alpine AS builder

# Install necessary build tools
RUN apk add --no-cache gcc musl-dev

# Set the working directory inside the container
WORKDIR /app

# Copy the Go source code into the container
COPY main.go .

# Build the Go application
RUN go build -o go-test-app main.go

# Use a minimal base image for the final container
FROM alpine:latest

# Install necessary packages to run the Go binary
RUN apk add --no-cache ca-certificates

# Set the working directory for the final image
WORKDIR /root/

# Copy the compiled binary from the builder stage
COPY --from=builder /app/go-test-app .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
CMD ["./go-test-app"]
