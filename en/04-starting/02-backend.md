> This page covers Tutorial v2. Elm 0.18.

# Backend

We will need a backend for our application, we can use __json-server__ for this.

[json-server](https://github.com/typicode/json-server) is an npm package that provides a quick way to create fake APIs.

Start a new node project:

```bash
yarn init
```

Accept all the defaults.

Install __json-server__:

```bash
yarn add json-server@0.9.5
```

Make __api.js__ in the root of the project:

```js
var jsonServer = require('json-server')

// Returns an Express server
var server = jsonServer.create()

// Set default middlewares (logger, static, cors and no-cache)
server.use(jsonServer.defaults())

var router = jsonServer.router('db.json')
server.use(router)

console.log('Listening at 4000')
server.listen(4000)
```

Add __db.json__ at the root:

```json
{
  "players": [
    { "id": "1", "name": "Sally", "level": 2 },
    { "id": "2", "name": "Lance", "level": 1 },
    { "id": "3", "name": "Aki", "level": 3 },
    { "id": "4", "name": "Maria", "level": 4 },
    { "id": "5", "name": "Julian", "level": 1 },
    { "id": "6", "name": "Jaime", "level": 1 }
  ]
}
```

Start the server by running:

```bash
node api.js
```

Test this fake API by browsing to:

- <http://localhost:4000/players>
