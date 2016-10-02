# 玩家（Players）模組

## Players messages

新增 __src/Players/Messages.elm__

```elm
module Players.Messages exposing (..)


type Msg
    = NoOp
```

這裡放置了所有關於玩家的訊息。

## 玩家模型

新增 __src/Players/Models.elm__

```elm
module Players.Models exposing (..)


type alias PlayerId =
    Int


type alias Player =
    { id : PlayerId
    , name : String
    , level : Int
    }


new : Player
new =
    { id = 0
    , name = ""
    , level = 1
    }
```

這裡定義了玩家紀錄。包含了 id、name 及 level。

注意到 `PlayerID` 的定義，就只是個 `Int` 的型別別名，這樣對清晰上非常有幫助，尤其當有函式需要許多 ids 的時候。舉例：

```elm
addPerkToPlayer : Int -> Int -> Player
```

用下列寫法更加清晰：

```elm
addPerkToPlayer : PerkId -> PlayerId -> Player
```

## 更新玩家

新增 __src/Players/Update.elm__

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

此更新目前沒有要作什麼事。
---

這是個基本樣式，大型應用程式的所有資源都會遵循：

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
