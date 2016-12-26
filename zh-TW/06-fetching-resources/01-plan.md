# 規劃

接下來是從 API 擷取玩家清單。

以下是規劃：

![Plan](01-plan.png)

(1-2) 當載入應用程式時，觸發擷取玩家的 Http 請求。這部份在 Html.App 的 `init` 完成。

(3-6) 當請求完成，觸發 `FetchAllDone` 伴隨著資料，訊息流到 `Players.Update`，將會更新玩家的集合。

(7-10) 接著，應用程式轉譯更新後的玩家列表。

## 函式依賴

我們需要 `http`，執行下列指令安裝：

```bash
elm package install evancz/elm-http
```
