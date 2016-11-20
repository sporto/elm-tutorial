>このページでは、Elm 0.17

# プレーヤーの更新

最後に、__src/Players/Update.elm__で`update`関数で新しいメッセージを考慮する必要があります：

新しいimportを追加します：

```bash
import Players.Commands exposing (save)
import Players.Models exposing (Player, PlayerId)
```

## 更新コマンドを作成する

プレイヤーをAPIに保存するためのコマンドを作成するためのヘルパー関数を追加します。

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

この関数は、 `ChangeLevel`メッセージを受け取ったときに呼び出されます。この関数は：

- プレーヤーIDとレベル差を受け取り、増減する
- 既存のプレイヤーのリストを受け取る
- リスト上の各プレイヤーのIDと、変更したいプレイヤーのIDを比較する
- idが私たちが望むものなら、そのプレイヤーのレベルを変更するコマンドを返す
- そして最後に実行するコマンドのリストを返す

## プレイヤーを更新する

サーバーからの応答を受け取ったときにプレーヤーを更新するための別のヘルパー関数を追加する：

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

この関数は、 `SaveSuccess`を介してAPIから更新されたプレーヤーを受け取ったときに使用されます。この関数は：

- 更新されたプレーヤーと既存のプレイヤーのリストを取得します。
- 各プレイヤーのIDと更新されたプレーヤーとの比較
- IDが同じ場合は更新されたプレーヤーを返し、そうでない場合は既存のプレーヤーを返します

## 更新するためのcase式の枝を追加する

`update`関数に新しいcase式の枝を追加する：

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

- `ChangeLevel`では、上で定義したヘルパー関数`changeLevelCommands`を呼び出します。この関数は実行するコマンドのリストを返すので、 `Cmd.batch`を使用してそれらを1つのコマンドにバッチ実行します。
- `SaveSuccess`ではヘルパー関数`updatePlayer`を呼び出し、関連するプレイヤーをリストから更新します。

---

# 試してみよう

上記が、プレイヤーのレベルを変更するために必要なすべての設定です。試してみましょう。編集ビューに行き、- ボタンと+ボタンをクリックするとレベルが変更されます。ブラウザを更新しても変更はサーバー上に保存されています。
