FROM node:12-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json .
RUN npm ci
COPY . .
RUN mv config.sample.yml config.yml
RUN npm run build

FROM busybox:musl AS deploy
RUN adduser -S nop-guide
USER nop-guide
RUN mkdir /home/nop-guide/nop-guide
WORKDIR /home/nop-guide/nop-guide
COPY --chown=nop-guide:root --from=builder dist .
COPY httpd.conf .
CMD busybox httpd -f -p 3000 -u nop-guide
