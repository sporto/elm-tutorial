> This page covers Elm 0.18

# 라우팅

앱에서 사용할 라우팅의 설정을 위해 __src/Routing.elm__ 모듈을 만듭시다.

이 모듈은 아래 내용을 다룹니다:

- 우리 앱에 쓰이는 루트
- 브라우저 경로를 루트에 연동하는 매쳐
- 라우팅 메시지에 대한 처리

__src/Routing.elm__ 를 작성합니다:

```elm
module Routing exposing (..)

import Navigation exposing (Location)
import Players.Models exposing (PlayerId)
import UrlParser exposing (..)


type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]


parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
```

---

모듈을 살펴봅시다.

### 루트

```elm
type Route
    = PlayersRoute
    | PlayerRoute PlayerId
    | NotFoundRoute
```

우리 앱에서 지정 가능한 루트들입니다.
`NotFoundRoute` 는 브라우저 경로에 해당하는 루트가 없을 때 사용됩니다.

### 매쳐 (Matchers)

```elm
matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map PlayersRoute top
        , map PlayerRoute (s "players" </> string)
        , map PlayersRoute (s "players")
        ]
```

매쳐를 정의했습니다. 파서는 url-parser 라이브러리에서 제공하는 것들입니다.

사용된 매쳐는 세 개입니다:

- 최상 루트에서 `PlayersRoute` 로 전달하도록 하나
- `/players` 에서 `PlayersRoute` 로 전달하는 하나
- `/players/id` 를 `PlayerRoute id` 로 전달하는 하나

순서가 중요하다는 점 기억하세요.

라이브러리에 대해서 더 궁금하면 이곳으로: <http://package.elm-lang.org/packages/evancz/url-parser>

### parseLocation

```elm
parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute
```

브라우저 주소가 변경될때마다 Navigation 라이브러리는 `Navigation.Location` 레코드를 담은 메시지를 보냅니다. 우리의 메인 `update` 에서는 `parseLocation` 에 이 레코드를 전달하여 호출합니다.

`parseLocation` 은 이 `Location` 을 파싱하여 찾은 `Route` 를 리턴합니다. 모든 매쳐가 실패하면 `NotFoundRoute` 을 리턴하는 것을 볼 수 있습니다.

현재는 라우팅에 해시를 사용하므로 `UrlParser.parseHash` 를 씁니다. 경로 (path) 를 사용하겠다면 `UrlParser.parsePath` 를 대신 쓰면 됩니다.
