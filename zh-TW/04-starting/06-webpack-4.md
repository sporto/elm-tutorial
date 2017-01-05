> 本頁包含 Elm 0.18

# Webpack 4

## package.json

最後，為了更容易執行伺服端，加入 npm scripts。修改 __package.json__ 將 `scripts` 替換成：

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

- 現在，執行 `npm run api` 便可啟動後端伺服端。
- `npm run build` 執行 webpack 建置並將綑綁結果放在 `dist` 目錄。
- `npm run watch` 啟動 webpack 看守，當程式碼異動時，將會把綑綁結果放在 `dist` 目錄。
- `npm run dev` 啟動 webpack 開發伺服端。

## Node Foreman

We have two servers to run for developing: the Api and the Frontend, we will need to launch both manually to test our application, this is ok but there is a nicer way.

開發中有兩個伺服端需要執行：API 及前端，需要手動將兩者啟動來測試應用程式，雖然可行但有更好的方法。

安裝 Node Foreman:

```
npm install -g foreman
```

在專案根目錄底下新增 `Procfile` 檔案：

```
api: npm run api
client: npm run dev
```

這會給予 cli 命令 `nf` 允許同時啟動或刪除兩個伺服端程序。

## 試試看

讓我們來試試看。

在終端機視窗下執行：

```bash
nf start
```

瀏覽 `http://localhost:3000/` 會看到應用程式輸出 "Hello"。使用 `Ctrl-c` 停止伺服器。

原始碼像是 <https://github.com/sporto/elm-tutorial-app/tree/018-02-webpack>。
