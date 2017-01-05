> 本頁包含 Elm 0.18

# 玩家訊息（Messages）

開始加入需要的訊息。

在 __src/Players/Messages.elm__ 檔案新增：

```elm
type Msg
    ...
    | ChangeLevel PlayerId Int
    | OnSave (Result Http.Error Player)
```

- 當使用者希望更改等級時，將會觸發 `ChangeLevel`。第二個參數為整數，指明更改多少等級，例如 -1 表示遞減， 1 表示遞增。
- 接著，希望能夠發送更新玩家的請求至 API。當 API 回應時將會觸發 `OnSave`。
- `OnSave` 將會是成功伴隨更新的玩家或者失敗的 Http 錯誤。