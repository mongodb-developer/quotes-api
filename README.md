# Quotes API

Simple Node.js application that exposes an API to get popular quotes.

This sample app was built to showcase how [MongoDB Atlas](https://mongodb.com/atlas) and [Gitpod](https://gitpod.io) are a great combination for a development environment in the cloud.

## How to start the API server

The API server can be started with:

```
$ node app.js
```
The server will listen for requests on port `3000`. Gitpod will make port `3000` automatically available in the browser and will expose the controls to make the URL public.

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
* `atlas_down`: a helper script to terminate the Atlas cluster associated with the Gitpod workspace. As there is no tear-down hook in Gitpod, it is recommended to run this command manually before terminating the environment.

Atlas clusters are terminate automatically when the Gitpod workspace is stopped.

### Caveats

When the Atlas cluster is created, the Atlas CLI automatically adds an access rule and a database user to the Atlas project to connect from the IP address associated with the Github workspace. The access rule and database user are not cleaned up when the cluster is terminated.

# Requirements

For this setup to work correctly you need the following:
* A Gitpod free account.
* A MongoDB Atlas account, preconfigured with a Project already created and an API key with Project Owner access
  * The projectId needs to be set as the Gitpod environment variable `MONGODB_ATLAS_PROJECT_ID`;
  * The API public key needs to be set as the Gitpod environment variable `MONGODB_ATLAS_PUBLIC_API_KEY`;
  * The API private key needs to be set as the Gitpod environment variable `MONGODB_ATLAS_PRIVATEC_API_KEY`.

If you don't have a MongoDB Atlas account and the environment variables listed above configured in your Gitpod settings the first time you start the environment, the creation of the Atlas cluster will fail.

But fear not! There is an easy fix. In the Gipod terminal, use the following command:

```
$ atlas setup --noBrowser
```

You will be guided through the creation of an Atlas account. The `noBrowser` is needed otherwise Gitpod tries to open the web page for the account setup with the terminal browser Lynx, which is not supported by the registration page.

Once you are all set, you can type the following command ([documentation](https://www.mongodb.com/docs/atlas/cli/stable/command/atlas-projects-apiKeys-create/)):

```
$ atlas projects apiKeys create [options]
```

This command will help you create the API key you need. To persist the API key to your Gitpod settings, you can use the [Gitpod CLI](https://www.gitpod.io/docs/references/gitpod-cli).
For example, you can do:

```
$ gp env MONGODB_ATLAS_PUBLIC_API_KEY=<your public API key>
```