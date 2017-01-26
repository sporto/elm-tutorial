> This page covers Elm 0.18

# 백엔드

백엔드가 필요할 겁니다. __json-server__ 를 사용하겠습니다.

[json-server](https://github.com/typicode/json-server) 는 빠르게 가상의 API 를 만들어 볼 수 있게 해주는 npm 패키지입니다.

새 node 프로젝트를 만듭니다:

```bash
npm init
```

전부 기본 항목으로 넘깁니다.

__json-server__ 를 설치합니다:

```bash
npm i json-server@0.9 -S
```

폴더 루트에 __api.js__ 를 작성합니다:

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

폴더 루트에 __db.json__ 을 추가합니다:

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

서버를 실행합니다:

```bash
node api.js
```

API 를 테스트해 볼 수 있습니다:

- <http://localhost:4000/players>
