> This page covers Elm 0.18

# 플레이어 커맨드

이제 서버에 요청할 커맨드를 작성해야 합니다. __src/Players/Commands.elm__ 를 만듭니다:

```elm
module Players.Commands exposing (..)

import Http
import Json.Decode as Decode exposing (field)
import Players.Models exposing (PlayerId, Player)
import Players.Messages exposing (..)


fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll


fetchAllUrl : String
fetchAllUrl =
    "http://localhost:4000/players"


collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder


memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)
```
---

코드를 살펴봅시다.

```elm
fetchAll : Cmd Msg
fetchAll =
    Http.get fetchAllUrl collectionDecoder
        |> Http.send OnFetchAll
```

어플리케이션에 사용할 커맨드입니다.

- `Http.get` 은 `리퀘스트` 를 만듭니다.
- 이 리퀘스트를 `Http.send` 에 전달하여 커맨드로 만듭니다.

```elm
collectionDecoder : Decode.Decoder (List Player)
collectionDecoder =
    Decode.list memberDecoder
```

이 디코더는 리스트의 각 멤버를 `memberDecoder` 로 처리합니다.

```elm
memberDecoder : Decode.Decoder Player
memberDecoder =
    Decode.map3 Player
        (field "id" Decode.string)
        (field "name" Decode.string)
        (field "level" Decode.int)
```

`memberDecoder` 는 `Player` 를 리턴하는 JSON 디코더입니다.

---
디코더 개념을 이해하기 위해 Elm repl 을 사용하겠습니다.

터미널에 `elm repl` 을 실행합니다. Json.Decoder 모듈을 임포트합니다:

```bash
> import Json.Decode exposing (..)
```

Json 문자열을 하나 선언합니다:

```bash
> json = "{\"id\":99, \"name\":\"Sam\"}"
```

`id` 를 추출할 디코더를 하나 만듭니다:

```bash
> idDecoder = (field "id" int)
```

Json 문자열을 파싱해서 `id` 를 정수형으로 가져오는 디코더입니다.

디코더를 사용해 봅시다:

```bash
> result = decodeString idDecoder  json
Ok 99 : Result.Result String Int
```

`Ok 99` 는 디코딩에 성공했고 얻은 값은 99 라는 의미입니다. `(field "id" Decode.int)` 는 단일 키를 파싱하는 디코더를 만든 겁니다.

한 단계는 넘었습니다. 이제 타입을 하나 선언해 봅니다:

```bash
> type alias Player = { id: Int, name: String }
```

Elm 에서 레코드 타입은 함수처럼 사용 가능합니다. `Player 1 "Sam"` 와 같은 식으로 플레이어 레코드를 만들 수 있습니다. 인자의 순서는 속성의 순서를 따라갑니다.

직접 해 봅시다:

```bash
> Player 1 "Sam"
{ id = 1, name = "Sam" } : Repl.Player
```

이제 두가지 원리를 알았으니 완전한 디코더를 만들 수 있습니다:

```bash
> nameDecoder = (field "name" string)
> playerDecoder = map2 Player idDecoder nameDecoder
```

`map2` 는 함수를 첫째 인자로 받고 (이 경우는 Player) 이후 디코더 둘을 인자로 받습니다. 내부적으로는 각 디코더를 실행하고 결과를 함수 (Player) 의 인자로 전달합니다.

써 봅시다:
```bash
> result = decodeString playerDecoder json
Ok { id = 99, name = "Sam" } : Result.Result String Repl.Player
```

---

커맨드가 __program__ 에 전달되기 전까지는 실제 실행되는 것은 없다는 걸 기억하세요.
