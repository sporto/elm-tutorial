# Backend

We will need a backend for our application, we can use __json-server__ for this.

[json-server](https://github.com/typicode/json-server) is an npm package that provides a quick way to create fake APIs. 

Start a new node project:

```
npm init
```

Accept all the defaults.

Install __json-server__:

```
npm i json-server -S
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

```
{
  "players": [
    { "id": 1, "name": "Sally", "level": 2 },
    { "id": 2, "name": "Lance", "level": 1 },
    { "id": 3, "name": "Aki", "level": 3 },
    { "id": 4, "name": "Maria", "level": 4 }
  ]
}

```

Start the server by running:

```bash
node api.js
```

Test this fake API by browsing to:

- <http://localhost:4000/players>
