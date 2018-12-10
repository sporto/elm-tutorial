
# Backend

We will need a backend for our application, this backend needs to serve some mock data so our Elm frontend can show something. 

[json-server](https://github.com/typicode/json-server) is an npm package that provides a quick way to create fake APIs.

Install __json-server__ by running:

```bash
npm add -D json-server
```

`json-server` needs a `json` file that defines the initial mock data.

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

We will want to run this server often, so is a good idea to have a script in our package.json.

In `package.json` add a `script` section:

```
  "devDependencies": {
    ...
  },
  "scripts": {
    "api": "json-server --watch db.json --port 4000"
  }
```

Let's try this server. Start it by running:

```bash
npm run api
```

Test this fake API by browsing to:

- <http://localhost:4000/players>
