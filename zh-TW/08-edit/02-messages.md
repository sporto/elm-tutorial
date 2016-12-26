# 玩家訊息（Messages）

開始加入需要的訊息。

在 __src/Players/Messages.elm__ 檔案新增：

```elm
type Msg
    ...
    | ChangeLevel PlayerId Int
    | SaveSuccess Player
    | SaveFail Http.Error
```

- 當使用者希望更改等級時，將會觸發 `ChangeLevel`。第二個參數為整數，指明更改多少等級，例如 -1 表示遞減， 1 表示遞增。
- 接著，希望能夠發送更新玩家的請求至 API。當 API 回應成功時將會觸發 `SaveSuccess`，失敗則是 `SaveFail`。
