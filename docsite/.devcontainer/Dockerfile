FROM mcr.microsoft.com/devcontainers/javascript-node:20

# ARG NODE_TLS_REJECT_UNAUTHORIZED=0
# RUN npm i -g pnpm
COPY certs/ /usr/local/share/ca-certificates/
RUN update-ca-certificates

# ENV NODE_TLS_REJECT_UNAUTHORIZED=0
# ARG NODE_TLS_REJECT_UNAUTHORIZED=0

# RUN chown -R node workspace
# USER node