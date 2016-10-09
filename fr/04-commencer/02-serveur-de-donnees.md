# Serveur de données

Il nous faudra un serveur pour les données de notre application.

Nous utiliserons [json-server](https://github.com/typicode/json-server), un paquet npm qui permet de créer rapidement des fausses APIs.

Démarrez un nouveau projet node :

```bash
npm init
```

Acceptez toutes les valeurs par défaut.

Installez __json-server__ :

```bash
npm i json-server -S
```

Créez le fichier __api.js__ à la racine du projet :

```js
var jsonServer = require('json-server')

// Retourne un serveur Express
var server = jsonServer.create()

// Définit les intergiciels (*middlewares*) par défaut (logger, static, cors et no-cache)
server.use(jsonServer.defaults())

var router = jsonServer.router('db.json')
server.use(router)

console.log('Listening at 4000')
server.listen(4000)
```

Créez __db.json__ à la racine :

```json
{
  "players": [
    { "id": 1, "name": "Sally", "level": 2 },
    { "id": 2, "name": "Lance", "level": 1 },
    { "id": 3, "name": "Aki", "level": 3 },
    { "id": 4, "name": "Maria", "level": 4 }
  ]
}
```

Démarrez le serveur en tapant :

```bash
node api.js
```

Testez cette fause API en vous rendant sur :

- <http://localhost:4000/players>
