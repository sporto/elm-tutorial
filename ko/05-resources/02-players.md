> This page covers Elm 0.18

# 플레이어 모듈

## 플레이어 메시지

__src/Players/Messages.elm__ 을 만듭니다.

```elm
module Players.Messages exposing (..)


type Msg
    = NoOp
```

플레이어 관련 모든 메시지를 여기 넣을 겁니다.

## 플레이어 모델

__src/Players/Models.elm__ 을 만듭니다.

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

플레이어 레코드를 정의합니다. 아이디, 이름, 레벨을 가지고 있습니다.

`PlayerId` 가 `String` 의 앨리어스임을 확인하세요. 이렇게 하는 게 이후 아이디와 관련된 함수들을 깔끔하게 표현합니다. 예를 들면:

```elm
addPerkToPlayer : Int -> Int -> Player
```

는 이렇게 쓰는 게 더 이해가 쉽습니다:

```elm
addPerkToPlayer : PerkId -> PlayerId -> Player
```

## 플레이어 업데이트

__src/Players/Update.elm__ 를 추가합니다.

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

이 업데이트는 지금은 딱히 하는 일이 없습니다.
---

이게 더 복잡한 어플리케이션에서 리소스가 동작하는 기본적인 패턴입니다:

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
