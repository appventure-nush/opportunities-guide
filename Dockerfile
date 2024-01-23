FROM node:12-alpine
RUN adduser -S nop-guide
USER nop-guide
RUN mkdir /home/nop-guide/nop-guide
WORKDIR /home/nop-guide/nop-guide
COPY --chown=nop-guide:root . .
RUN mv config.sample.yml config.yml
