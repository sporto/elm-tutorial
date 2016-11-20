>このページでは、Elm 0.17

# メイン

## メインのモデル

__src/Models.elm__のハードコーディングされたプレイヤーのリストを削除します。

```elm
initialModel : Model
initialModel =
    { players = []
    }
```

## メイン

最後に、アプリケーションを起動するときに `fetchAll`を実行します。

__src/Main.elm__を以下のように修正します：

```elm
...
import Messages exposing (Msg(..))
...
import Players.Commands exposing (fetchAll)

init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.map PlayersMsg fetchAll )
```

これで `init`はアプリケーションの起動時に実行するコマンドのリストを返します。
