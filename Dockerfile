FROM node:12-alpine

ARG GATSBY_RELEASE_ENV
ENV GATSBY_RELEASE_ENV=$GATSBY_RELEASE_ENV

ADD . / payidorg/

RUN npm install --cache .npm --no-audit --prefer-offline -g gatsby-cli
RUN npm install --cache .npm --no-audit --prefer-offline --prefix ./payidorg
RUN (cd payidorg/; gatsby build;)

WORKDIR /payidorg

FROM nginx:1.17-alpine
COPY --from=0 /payidorg/public /usr/share/nginx/html
