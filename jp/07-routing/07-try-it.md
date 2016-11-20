# 試してみよう

これまでのことを試してみましょう。 次のようにしてアプリケーションを実行します。

```bash
npm run dev
```

また、別の端末で以下を実行します。

```bash
npm run api
```

ブラウザで `http://localhost:3000`に行きます。 ユーザーの一覧が表示されます。

![screenshot](07-list.png)

`http://localhost:3000/#players/2`に行くと、1人のユーザーが表示されます。

![screenshot](07-edit.png)

次に、ナビゲーションを追加します。

---

UrlParserの代わりに使用できる、ルーティングマッチを実行するライブラリがいくつかあります。例えば、[Hop](https://github.com/sporto/hop)をチェックしてください。
