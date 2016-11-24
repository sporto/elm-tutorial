> This page covers Elm 0.18

# Webpackその4

## package.json

最後に、npmスクリプトを追加して、サーバを簡単に実行できるようにします。 __package.json__で `scripts`を以下のように置き換えてください：

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

- これで `npm run api`がフェイクのサーバーを実行します。
- `npm run build`はwebpackビルドを作成し、バンドルを`dist`に置きます。
- `npm run watch`はwebpackウォッチャーを実行し、ソースコードが変更された時にバンドルを`dist`に置きます。
- `npm run dev`はwebpack dev serverを実行します。

## Node Foreman

ApiとFrontendの2つのサーバーがあり、アプリケーションをテストするために手動で両方を起動する必要があります。これでも問題ありませんが、より良い方法があります。

Node Foremanをインストールします:

```
npm install -g foreman
```

プロジェクトのルートに `Procfile`という名前のファイルを作成します：

```
api: npm run api
client: npm run dev
```

これは、同時に処理された両方を起動して終了させる `nf`というcliコマンドを与えます。

## テストする

セットアップをテストしましょう。

ターミナルウィンドウで以下を実行します：

```bash
nf start
```

`http://localhost:3000/`を参照すると、アプリケーションが表示され、 "Hello"が出力されます。サーバを終了するには`Ctrl-c`を使います。

アプリケーションコードは<https://github.com/sporto/elm-tutorial-app/tree/02-webpack>のようになります。
