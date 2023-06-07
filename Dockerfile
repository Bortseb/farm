FROM node:lts-alpine
RUN apk add --update --no-cache \
  dumb-init \
  git \
  jq
WORKDIR "/home/node"
ARG WIKI_PACKAGE=wiki-farm-tlsfriends@0.1.1
USER node
RUN npm install -g --prefix . $WIKI_PACKAGE
RUN mkdir -p .wiki
VOLUME "/home/node/.wiki"
EXPOSE 3000
ENV PATH="${PATH}:/home/node/bin"
ENV NPM_CONFIG_PREFIX="${HOME}"
ENTRYPOINT ["dumb-init"]
CMD ["wiki", "--farm", "--security_type=tlsfriends"]