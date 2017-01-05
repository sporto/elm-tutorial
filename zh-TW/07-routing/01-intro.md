> 本頁包含 Elm 0.18

# 簡介

讓我們加入路由到應用程式。使用 [Elm Navigation 包](http://package.elm-lang.org/packages/elm-lang/navigation/) 及 [UrlParser](http://package.elm-lang.org/packages/evancz/url-parser/)。

- Navigation 提供了更改瀏覽器網址及對應的方法
- UrlParser 提供路由比對器

首先安裝：

```bash
elm package install elm-lang/navigation
elm package install evancz/url-parser
```

 `Navigation` 函式庫包裝 `Html.App`。包含了 `Html.App` 所有功能並額外加上：

 - 監聽瀏覽器網址的改變
 - 當網址改變時觸發訊息
 - 提供改變瀏覽器網址的方法

## 流程

用以下幾張圖表了解路由的運作。

### 初始轉譯

![流程](01-intro.png)

- (1) 當第一次讀取 `Navigation` 模組，將會擷取目前的 `Location` 送到應用程式的 `init` 函式。
- (2) 在 `init` 函式中剖析 location 並取得符合的 `Route`。
- (3, 4) 接著將符合的 `Route` 儲存在初始模型，將初始模型傳回到 `Navigation`。
- (5, 6) `Navigation` 使用初始模型來轉譯視界。

### 當網址改變

![流程](01-intro_001.png)

- (1) 當瀏覽器網址改變時，Navigation 函式庫接收到事件
- (2) 一個 `OnLocationChange` 訊息會送到 `update` 函式，此訊息包含新的網址
- (3, 4) 在 `update` 中，剖析 `Location` 並傳回符合的 `Route`
- (5) 從 `update` 傳回了更新後的模型，包含更新 `Route`。
- (6, 7) Navigation 接著渲染應用程式