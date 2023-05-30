FROM node:lts-alpine
RUN apk add --update --no-cache \
  dumb-init \
  git \
  jq
WORKDIR "/home/node"
ARG WIKI_PACKAGE=wiki@0.29.0
USER node
RUN npm install -g --prefix . $WIKI_PACKAGE
RUN cd lib/node_modules/wiki/node_modules && \
  git clone https://github.com/Bortseb/wiki-security-tlsfriends.git
RUN cd lib/node_modules/wiki/node_modules/wiki-security-tlsfriends && \
  npm install && \
  node_modules/grunt/bin/grunt
RUN mkdir -p .wiki
VOLUME "/home/node/.wiki"
EXPOSE 3000
ENV PATH="${PATH}:/home/node/bin"
ENV NPM_CONFIG_PREFIX="${HOME}"
ENTRYPOINT ["dumb-init"]
CMD ["wiki", "--farm", "--security_type=tlsfriends"]