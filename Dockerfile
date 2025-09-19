FROM debian:11-slim

RUN apt-get update && apt-get install -y openconnect openssh-client procps && rm -rf /var/lib/apt/lists/*

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
