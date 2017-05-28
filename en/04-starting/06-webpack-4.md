> This page covers Tutorial v2. Elm 0.18.

# Webpack 4

## package.json

Finally we want to add some npm scripts so we can run our servers easily. In __package.json__ add a `scripts` section:

```json
{
  ...
  "scripts": {
      "api": "node api.js",
      "build": "webpack",
      "client": "webpack-dev-server --port 3000"
  },
  ...
}
```

- So now `yarn api` will run our fake server.
- `yarn build` will create a webpack build and put the bundles in `dist`.
- `yarn client` runs the webpack dev server.

## Node Foreman

We have two servers to run for developing: the Api and the Frontend, we will need to launch both manually to test our application, this is ok but there is a nicer way using a package called Foreman.

Install Node Foreman:

```
yarn add foreman
```

Then create a file called `Procfile` in the root of the project with:

```
api: yarn api
client: yarn client
```

Edit __package.json__ to include a new script:

```
"scripts": {
  ...,
  "start": "nf start"
}
```

## Test it

Let's test our setup

In a terminal window run:

```bash
yarn start
```

If you browse to `http://localhost:3000/` you should see our application, which outputs "Hello". Use `Ctrl-c` to stop the servers.

Your application code should look like <https://github.com/sporto/elm-tutorial-app/tree/018-02-webpack>.
