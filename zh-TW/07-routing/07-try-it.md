# 試試看

讓我們試試看目前的成果。執行下列指令：

```bash
npm run dev
```

在另一個終端機執行：


```bash
npm run api
```

接著使用瀏覽器前往 `http://localhost:3000`。你會看到使用者列表。

![screenshot](07-list.png)

如果切換到 `http://localhost:3000/#players/2`，你會看到一名使用者。

![screenshot](07-edit.png)

接下來，我們要增加某些導覽。

---

除了 UrlParser，也有其他的路由比對函式庫可以使用，例如 [Hop](https://github.com/sporto/hop)。
