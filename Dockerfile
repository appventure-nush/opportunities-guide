FROM node:14-alpine AS base

FROM base AS modules

WORKDIR /app
# install only production modules
COPY package.json package-lock.json .
RUN npm ci --omit=dev

FROM base AS deploy

RUN adduser -S nop-guide
USER nop-guide
RUN mkdir /home/nop-guide/nop-guide
WORKDIR /home/nop-guide/nop-guide

# from dev/build/Dockerfile
COPY --chown=nop-guide:root ./assets ./assets
COPY --chown=nop-guide:root --from=modules /app/node_modules ./node_modules
COPY --chown=nop-guide:root ./server ./server
COPY --chown=nop-guide:root ./package.json ./package.json
COPY --chown=nop-guide:root ./LICENSE ./LICENSE

COPY --chown=nop-guide:root ./config.sample.yml ./config.yml
