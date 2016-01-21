# Backend

We will need a backend for our application, we can use __json-server__ for this.

Start a new node project:

```
npm init
```

Accept all the defaults.

Install __json-server__:

```
npm i json-server -S
```

Make `index.js` in the root of the project:

```js
ss
```

Add `db.json` at the root:

```
{
  "players": [
    {
      "id": 1,
      "name": "Sally",
      "level": 2
    },
    {
      "id": 2,
      "name": "Lance",
      "level": 1
    },
    {
      "id": 3,
      "name": "Aki",
      "level": 3
    },
    {
      "id": 4,
      "name": "Maria",
      "level": 4
    }
  ],
  "perks": [
    {
      "id": 1,
      "name": "Steel armor",
      "strengh": 2
    },
    {
      "id": 2,
      "name": "Scroll of protection",
      "strengh": 2
    },
    {
      "id": 3,
      "name": "Steel sword",
      "strengh": 1
    },
    {
      "id": 4,
      "name": "Amulet of luck",
      "strengh": 1
    }
  ],
  "perksPlayers": [
    {
      "perkId": 1,
      "playerId": 1
    },
    {
      "perkId": 2,
      "playerId": 2
    },
    {
      "perkId": 3,
      "playerId": 3
    },
    {
      "perkId": 4,
      "playerId": 4
    },
  ]
}

```

Start the server by doing:

```bash
node index.js
```

