# Quotes API

Simple Node.js application that exposes an API to get popular quotes.

This sample app was built to showcase how [MongoDB Atlas](https://mongodb.com/atlas) and [Gitpod](https://gitpod.io) are a great combination for a development environment in the cloud.

## What's available in the Gitpod environment

This repository is configured to be able to start coding right away. When the environment boots up, the following things happen:

* The Gitpod workspace starts up, and VS Code is configured with the [Standard](https://marketplace.visualstudio.com/items?itemName=standard.vscode-standard) extension and the MongoDB for [VS Code extension](https://marketplace.visualstudio.com/items?itemName=mongodb.mongodb-vscode);
* The Node.js dependencies are installed;
* A free MongoDB Atlas cluster is created, with the same name as the Gitpod workspace;
* A `.env` file is created, containing a `MONGODB_CONNECTION_STRING` variable set to the connection string for the cluster that was created;
* The cluster is seeded with sample data, with a script for the MongoDB Shell (`mongosh`);
* An Atlas Search index is created to support full-text search use cases.

In the workspace, the following commands are available:
* `atlas`: the Atlas CLI to manage your clusters, search indexes and more;
* `mongosh`: the MongoDB Shell;
* `atlas_up`: a helper script to create the Atlas cluster associated with the Gitpod workspace. This is the script that Gitpod runs when the workspace is created;
* `atals_down`: a helper script to terminate the  Atlas cluster associated with the Gitpod workspace. As there is no tear-down hook in Gitpod, it is recommended to run this command manually before terminating the environment.

### Caveats

When the Atlas cluster is created, the Atlas CLI automatically adds an access rule and a database user to the Atlas project to connect from the IP address associated with the Github workspace. The access rule and database user are not cleaned up when the cluster is terminated.

# Requirements

For this setup to work correctly you need the following:
* A Gitpod free account.
* A MongoDB Atlas account, preconfigured with a Project already created and an API key with Project Owner access
  * The projectId needs to be set as the Gitpod environment variable `MONGODB_ATLAS_PROJECT_ID`;
  * The API public key needs to be set as the Gitpod environment variable `MONGODB_ATLAS_PUBLIC_API_KEY`;
  * The API private key needs to be set as the Gitpod environment variable `MONGODB_ATLAS_PRIVATEC_API_KEY`.
