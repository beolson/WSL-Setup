<<<<<<< HEAD
FROM mcr.microsoft.com/devcontainers/javascript-node:20

# ARG NODE_TLS_REJECT_UNAUTHORIZED=0
# RUN npm i -g pnpm
COPY certs/ /usr/local/share/ca-certificates/
=======
FROM mcr.microsoft.com/devcontainers/javascript-node:18

# ARG NODE_TLS_REJECT_UNAUTHORIZED=0
# RUN npm i -g pnpm
# by using a glob pattern, for the certs directory, docker will not error if certs directory does not exist
COPY cert[s]/ /usr/local/share/ca-certificates/
>>>>>>> 4b418b6f84b4c2dd995089bc7fdf154320ba478d
RUN update-ca-certificates

# ENV NODE_TLS_REJECT_UNAUTHORIZED=0
# ARG NODE_TLS_REJECT_UNAUTHORIZED=0

# RUN chown -R node workspace
# USER node