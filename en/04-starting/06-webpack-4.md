> This page covers Tutorial v2. Elm 0.18.

# Webpack 4

## package.json

Finally we want to add some yarn scripts so we can run our servers easily. In __package.json__ replace `scripts` with:

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

- So now `yarn api` will run our fake server.
- `yarn build` will create a webpack build and put the bundles in `dist`.
- `yarn watch` runs the webpack watcher which puts the bundles in `dist` as we change our source code.
- `yarn dev` runs the webpack dev server.

## Node Foreman

We have two servers to run for developing: the Api and the Frontend, we will need to launch both manually to test our application, this is ok but there is a nicer way.

Install Node Foreman:

```
yarn global add foreman
```

Then create a file called `Procfile` in the root of the project with:

```
api: yarn api
client: yarn dev
```

This will give us a cli command called `nf` that allows to launch and kill both processed at the same time.

## Test it

Let's test our setup

In a terminal window run:

```bash
nf start
```

If you browse to `http://localhost:3000/` you should see our application, which outputs "Hello". Use `Ctrl-c` to stop the servers.

Your application code should look like <https://github.com/sporto/elm-tutorial-app/tree/018-02-webpack>.
