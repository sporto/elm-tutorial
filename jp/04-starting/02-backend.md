# バックエンド

アプリケーションのバックエンドが必要ですが、__json-server__を使用することができます。

[json-server](https://github.com/typicode/json-server)は、偽のAPIを素早く作成できるnpmパッケージです。

新しいノードプロジェクトを開始します。

```bash
npm init
```

すべてのデフォルト値を受け入れます。

__json-server__をインストールします：

```bash
npm i json-server -S
```

プロジェクトのルートに__api.js__を作成します。

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

ルートに__db.json__を追加します：

```json
{
  "players": [
    { "id": 1, "name": "Sally", "level": 2 },
    { "id": 2, "name": "Lance", "level": 1 },
    { "id": 3, "name": "Aki", "level": 3 },
    { "id": 4, "name": "Maria", "level": 4 },
    { "id": 5, "name": "Julian", "level": 1 },
    { "id": 6, "name": "Jaime", "level": 1 }
  ]
}
```

次のコマンドを実行してサーバーを起動します。

```bash
node api.js
```

参照することによってこの偽のAPIをテストしてください：

- <http://localhost:4000/players>

