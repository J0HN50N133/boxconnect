FROM alpine:3.19

RUN apk add --no-cache openconnect openssh-client procps bash curl

COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]
