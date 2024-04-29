FROM rust:latest as builder

WORKDIR /usr/src/car-server
COPY . .
RUN cargo install --path .

FROM debian:bookworm-slim

WORKDIR /app

COPY Rocket.toml .
COPY --from=builder /usr/local/cargo/bin/server /app/server
RUN chmod +x /app/server

ENTRYPOINT ["/app/server"]