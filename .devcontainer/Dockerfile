# This file is a customization of https://github.com/devcontainers/images/blob/main/src/javascript-node/.devcontainer/Dockerfile

# [Choice] Node.js version (use -bullseye variants on local arm64/Apple Silicon): 20, 18, 16, 20-bullseye, 18-bullseye, 16-bullseye, 20-buster, 18-buster, 16-buster
ARG VARIANT=20-bullseye
FROM node:${VARIANT}

ARG USERNAME=node
ARG NPM_GLOBAL=/usr/local/share/npm-global

# Add NPM global to PATH.
ENV PATH=${NPM_GLOBAL}/bin:${PATH}

RUN \
    # Configure global npm install location, use group to adapt to UID/GID changes
    if ! cat /etc/group | grep -e "^npm:" > /dev/null 2>&1; then groupadd -r npm; fi \
    && usermod -a -G npm ${USERNAME} \
    && umask 0002 \
    && mkdir -p ${NPM_GLOBAL} \
    && touch /usr/local/etc/npmrc \
    && chown ${USERNAME}:npm ${NPM_GLOBAL} /usr/local/etc/npmrc \
    && chmod g+s ${NPM_GLOBAL} \
    && npm config -g set prefix ${NPM_GLOBAL} \
    && su ${USERNAME} -c "npm config -g set prefix ${NPM_GLOBAL}" \
    # Install eslint
    && su ${USERNAME} -c "umask 0002 && npm install -g eslint" \
    && npm cache clean --force > /dev/null 2>&1

# Install the Atlas CLI and mongosh
# It should be faster to do it here than to do it in devcontainer.json with "features"
RUN apt-get install -y gnupg \
 && wget -qO - https://pgp.mongodb.com/server-5.0.asc | apt-key add - \
 && echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-5.0.list \
 && apt-get update \
 && apt-get install -y mongodb-atlas

# Install modules that MongoDB for VS Code Playgrounds need to find in home directory
WORKDIR /home/${USERNAME}
RUN su ${USERNAME} -c "npm install node-fetch@2"

COPY .devcontainer/mongodb-utils.sh /home/${USERNAME}/.mongodb-utils.sh
RUN su ${USERNAME} -c "echo \"source ~/.mongodb-utils.sh\" >> ~/.bash_aliases"