>This page covers Elm 0.18

# Playersモジュール

## Playersメッセージ

__src/Players/Messages.elm__を作成する。

```elm
module Players.Messages exposing (..)


type Msg
    = NoOp
```

ここでは、プレイヤーに関連するすべてのメッセージを記入します。

## Playersモデル

__src/Players/Models.elm__を作成する。

```elm
module Players.Models exposing (..)


type alias PlayerId =
    String


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


new : Player
new =
    { id = "0"
    , name = ""
    , level = 1
    }
```

ここでは、プレーヤーのレコードの外観を定義します。 ID、名前、レベルがあります。

`PlayerId`の定義にも注意してください。これは`Int`の単なるエイリアスです。これは、複数のIDを引数に取る関数を後で導入することになった場合にわかりやすくなり便利です。例えば：

```elm
addPerkToPlayer : Int -> Int -> Player
```

よりも、次のように書かれているとはるかに明確です。

```elm
addPerkToPlayer : PerkId -> PlayerId -> Player
```

## プレーヤーの更新

__src/Players/Update.elm__を追加する

```elm
module Players.Update exposing (..)

import Players.Messages exposing (Msg(..))
import Players.Models exposing (Player)


update : Msg -> List Player -> ( List Player, Cmd Msg )
update message players =
    case message of
        NoOp ->
            ( players, Cmd.none )
```

この`update`は現時点では何もしません。

---

これらは、より大きなアプリケーションのすべてのリソースが従う基本パターンです。

```
Messages
Models
Update
Players
    Messages
    Models
    Update
Perks
    Messages
    Models
    Update
...
```
