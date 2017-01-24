> This page covers Elm 0.18

# 플레이어 커맨드

API 를 통해 플레이어를 업데이트하는 커맨드를 만듭니다.

__src/Players/Commands.elm__ 에 아래 내용을 추가합니다:

```elm
import Json.Encode as Encode

...

saveUrl : PlayerId -> String
saveUrl playerId =
    "http://localhost:4000/players/" ++ playerId


saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody
        , expect = Http.expectJson memberDecoder
        , headers = []
        , method = "PATCH"
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }


save : Player -> Cmd Msg
save player =
    saveRequest player
        |> Http.send OnSave


memberEncoded : Player -> Encode.Value
memberEncoded player =
    let
        list =
            [ ( "id", Encode.string player.id )
            , ( "name", Encode.string player.name )
            , ( "level", Encode.int player.level )
            ]
    in
        list
            |> Encode.object
```

### 저장 요청 (Save request)

```elm
saveRequest : Player -> Http.Request Player
saveRequest player =
    Http.request
        { body = memberEncoded player |> Http.jsonBody ➊
        , expect = Http.expectJson memberDecoder ➋
        , headers = []
        , method = "PATCH" ➌
        , timeout = Nothing
        , url = saveUrl player.id
        , withCredentials = False
        }
```

➊ 주어진 플레이어를 JSON 문자열로 인코드합니다.
➋ 돌아오는 응답을 어떻게 파싱할지 지정합니다. 현재는 돌아온 JSON 데이터를 Elm 값으로 디코딩합니다.
➌ `PATCH` 는 우리 API 에서 레코드의 업데이트를 위해 제공하는 http 메소드입니다.

### 저장

```elm
save : Player -> Cmd Msg
save player =
    saveRequest player ➊
        |> Http.send OnSave ➋
```

`Http.send` ➋ 를 사용해 앞에서 만든 메시지와 저장 요청 ➊ 을 엮어 커맨드로 만듭니다.
`Http.send` 는 메시지 생성자 (이 경우 `OnSave`) 를 인자로 받습니다. 요청이 처리되면, Elm 에서 요청의 결과를 `OnSave` 에 담아 호출합니다.
