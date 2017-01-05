# 主模組（Main modules）

這個主層級需要鉤上先前所建立的 Players 模組。

建立連結：

```elm
主訊息    --->    玩家訊息
主模型    --->    玩家模型
主更新    --->    玩家更新
```

## 主訊息

修改 __src/Messages.elm__ 來包含玩家訊息：

```elm
module Messages exposing (..)

import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
```

## 主模型

修改 __src/Models.elm__ 來包含玩家：

```elm
module Models exposing (..)

import Players.Models exposing (Player)


type alias Model =
    { players : List Player
    }


initialModel : Model
initialModel =
    { players = [ Player "1" "Sam" 1 ]
    }
```

這裡暫時寫死玩家。

## 主更新

更改 __src/Update.elm__ 成：

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

這裡遵循 Elm 架構：

- 所有 `PlayersMsg` 發送到 `Players.Update`。
- 使用樣式對應取出結果給 `Players.Update`
- 傳回模型，包含更新後玩家列表及需要執行的命令。
