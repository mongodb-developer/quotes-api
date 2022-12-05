FROM gitpod/workspace-base:2022-09-07-02-19-02

# Install MongoDB Tooling
RUN sudo apt-get install gnupg
RUN wget -qO - https://pgp.mongodb.com/server-5.0.asc | sudo apt-key add -
RUN echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
RUN sudo apt-get update
RUN sudo apt-get install -y mongodb-atlas

# Install Node 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
RUN sudo apt-get install -y nodejs

# Copy Atlas script
COPY mongodb-utils.sh /home/gitpod/.mongodb-utils.sh
RUN echo "source ~/.mongodb-utils.sh" >> .bash_aliases