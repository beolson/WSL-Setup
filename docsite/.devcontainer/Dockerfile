FROM mcr.microsoft.com/devcontainers/javascript-node:18

# ARG NODE_TLS_REJECT_UNAUTHORIZED=0
# RUN npm i -g pnpm
# by using a glob pattern, for the certs directory, docker will not error if certs directory does not exist
COPY cert[s]/ /usr/local/share/ca-certificates/
RUN update-ca-certificates

# ENV NODE_TLS_REJECT_UNAUTHORIZED=0
# ARG NODE_TLS_REJECT_UNAUTHORIZED=0

# RUN chown -R node workspace
# USER node