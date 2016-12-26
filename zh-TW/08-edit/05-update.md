# 玩家更新（Update）

最後，需要在 `update` 函式中解釋新的訊息。位於 __src/Players/Update.elm__ 檔案：

新增 import：

```bash
import Players.Commands exposing (save)
import Players.Models exposing (Player, PlayerId)
```

## 新增更新命令

新增 helper 函式，用來給儲存玩家 API 產生命令。

```elm
changeLevelCommands : PlayerId -> Int -> List Player -> List (Cmd Msg)
changeLevelCommands playerId howMuch players =
    let
        cmdForPlayer existingPlayer =
            if existingPlayer.id == playerId then
                save { existingPlayer | level = existingPlayer.level + howMuch }
            else
                Cmd.none
    in
        List.map cmdForPlayer players
```

當收到 `ChangeLevel` 訊息時，此函式會被呼叫：

- 收到玩家 id 及不同的等級
- 收到既有玩家的列表
- 針對列表中每一個玩家，比對其 id 是否與我們要修改的玩家 id 相符
- 如果有符合，傳回命令修改該玩家等級
- 最後傳回欲執行的命令列表

## 更新玩家

新增另一個 helper 函式，當收到 server 回應時更新玩家：

```elm
updatePlayer : Player -> List Player -> List Player
updatePlayer updatedPlayer players =
    let
        select existingPlayer =
            if existingPlayer.id == updatedPlayer.id then
                updatedPlayer
            else
                existingPlayer
    in
        List.map select players
```

當我們從 API 收到 `SaveSuccess` 訊息時將會呼叫此函式：

- 取得更新後玩家及既有玩家的列表
- 針對列表中每一個玩家，比對其 id 是否與更新後玩家相同
- 如果有符合，傳回更新後玩家，否則傳回既有玩家

## 增加分支到 update

新增分支到 `update` 函式：

```elm
update message players =
    case message of
        ...

        ChangeLevel id howMuch ->
            ( players, changeLevelCommands id howMuch players |> Cmd.batch )

        SaveSuccess updatedPlayer ->
            ( updatePlayer updatedPlayer players, Cmd.none )

        SaveFail error ->
            ( players, Cmd.none )
```

- 在 `ChangeLevel` 呼叫 helper 函式 `changeLevelCommands`。函式傳回欲執行的命令列表，可以使用 `Cmd.batch` 批次執行命令。
- 在 `SaveSuccess` 呼叫 helper 函式 `updatePlayer`。函式將會更新列表中相關的玩家。

---

# 試試看

就是這些了，更改玩家等級所需的東西。試試看，前往編輯視界，點擊 - 及 + 按鈕。你會看到等級改變，若重新整理頁面，這些改變持續的儲存在 server。
