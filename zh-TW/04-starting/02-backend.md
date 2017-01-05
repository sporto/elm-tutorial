> 本頁包含 Elm 0.18

# 後端

我們使用 __json-server__ 作為應用程式的後端。

[json-server](https://github.com/typicode/json-server) 是個 npm 包，快速建立假的 API。

開始新的 node 專案：

```bash
npm init
```

接受所有預設值。

安裝 __json-server__：

```bash
npm i json-server@0.9 -S
```

專案根目錄底下新增 __api.js__：

```js
var jsonServer = require('json-server')

// 傳回 Express 伺服端
var server = jsonServer.create()

// 設定預設中介層（logger、靜態、cors 及 no-cache）
server.use(jsonServer.defaults())

var router = jsonServer.router('db.json')
server.use(router)

console.log('Listening at 4000')
server.listen(4000)
```

專案根目錄底下新增 __db.json__：

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

啟動伺服端：

```bash
node api.js
```

瀏覽下列網址測試 API 後端：

- <http://localhost:4000/players>
