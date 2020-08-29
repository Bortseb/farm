FROM node:lts-alpine

RUN apk add --update --no-cache \
  dumb-init \
  git \
  jq
WORKDIR "/home/node"
ARG WIKI_PACKAGE=wiki@0.21.2
RUN su node -c "npm install -g --prefix . $WIKI_PACKAGE"
RUN su node -c "mkdir -p .wiki"
VOLUME "/home/node/.wiki"
EXPOSE 3000
USER node
ENV PATH="${PATH}:/home/node/bin"
# Adding this line to make local plugin development easier
# see https://local-farm.wiki.dbbs.co/make-a-new-plugin.html
ENV NPM_CONFIG_PREFIX="${HOME}"
ENTRYPOINT ["dumb-init"]
CMD ["wiki", "--farm", "--security_type=friends"]
