> This page covers Elm 0.18

# 메인

메인 레벨에서 앞에서 만든 플레이어 모듈에 접근해야겠죠.

이렇게 참조할 겁니다:

```elm
Main Messages  --->    Players Messages
Main Models    --->    Players Models
Main Update    --->    Players Update
```

## 메인 메시지

__src/Messages.elm__ 를 플레이어 메시지를 포함하도록 수정합니다:

```elm
module Messages exposing (..)

import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
```

## 메인 모델

__src/Models.elm__ 에서 플레이어를 포함하도록 합니다:

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

일단은 플레이어 하나를 하드코드 해두겠습니다.

## 메인 업데이트

__src/Update.elm__ 를 수정합니다:

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

여기서도 Elm 아키텍쳐를 따르고 있습니다:

- 모든 `PlayersMsg` 는 `Players.Update` 로 보내집니다.
- 패턴 매칭으로 `Players.Update` 의 결과를 추출합니다.
- 새로운 플레이어 리스트와 커맨드를 모델에 포함시켜 리턴합니다.
