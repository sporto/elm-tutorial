>このページでは、Elm 0.18

# メイン

メインレベルは私たちが作成したPlayersモジュールに接続する必要があります。

以下のように関連付ける必要があります：

```elm
メインメッセージ  ---> プレイヤーメッセージ
メインモデル     ---> プレイヤーモデル
メイン更新       ---> プレイヤー更新
```

## メインメッセージ

__src/Messages.elm__を変更してプレイヤーメッセージを追加する：

```elm
module Messages exposing (..)

import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
```

## 主なモデル

プレイヤーを含めるように__src/Models.elm__を変更する：

```elm
module Models exposing (..)

import Players.Models exposing (Player)


type alias Model =
    { players : List Player
    }


initialModel : Model
initialModel =
    { players = [ Player 1 "Sam" 1 ]
    }
```

ここでは、1名のプレーヤーをハードコーディングしておきます。

## メインの更新

__src/Update.elm__を次のように変更します。

```elm
module Update exposing (..)

import Messages exposing (Msg(..))
import Models exposing (Model)
import Players.Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        PlayersMsg subMsg ->
            let
                ( updatedPlayers, cmd ) =
                    Players.Update.update subMsg model.players
            in
                ( { model | players = updatedPlayers }, Cmd.map PlayersMsg cmd )
```

ここではElmアーキテクチャに従います：

- すべてのPlayersMsgは `Players.Update`にルーティングされます。
- パターンマッチングを使用して `Players.Update`の結果を抽出します
- 更新されたプレーヤーリストと実行する必要のあるコマンドを含むモデルを返します。
