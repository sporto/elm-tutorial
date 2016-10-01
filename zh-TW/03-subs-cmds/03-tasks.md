# 任務（Tasks）

我們已經見到如何使用命令，收集副作用的結果。但是命令並沒有成功或失敗的概念。也沒有連續的概念。命令只是一包東西要做。

Elm 中，使用__任務__給非同步操作，任務可以成功或失敗，還可以串接。例如：先做這，再做那。這跟 JavaScript 的 promises 十分相似。

任務有個標記式：`Task errorValue successValue`。第一個引數為失敗型別，第二個為成功型別。例如：

- `Task Http.Error String` 任務失敗為 Http.Error 或成功為字串
- `Task Never Result` 任務從不失敗，永會成功帶著 `Result`。

任務通常從函式傳回，函式希望做些非同步的操作，例如：發送一個 Http 請求。

## 與命令的關係

當我們從函式庫得到一個任務，需要將任務包裝成一個命令，這樣才可以命令送到 __Html.App__。

讓我們來看個範例，首先，安裝額外的函式庫：

```bash
elm package install evancz/elm-http
```

接著是應用程式：

```elm
module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.App
import Http
import Task exposing (Task)
import Json.Decode as Decode


-- 模型


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "", Cmd.none )



-- 訊息


type Msg
    = Fetch
    | FetchSuccess String
    | FetchError Http.Error



-- 視界


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Fetch ] [ text "Fetch" ]
        , text model
        ]


decode : Decode.Decoder String
decode =
    Decode.at [ "name" ] Decode.string


url : String
url =
    "http://swapi.co/api/planets/1/?format=json"


fetchTask : Task Http.Error String
fetchTask =
    Http.get decode url


fetchCmd : Cmd Msg
fetchCmd =
    Task.perform FetchError FetchSuccess fetchTask



-- 更新


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, fetchCmd )

        FetchSuccess name ->
            ( name, Cmd.none )

        FetchError error ->
            ( toString error, Cmd.none )



-- 主程式


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }
```

此應用程式從 swapi（星際大戰（Star Wars）API）擷取一個行星名稱。目前只會擷取行星 1 的名稱，名稱為 Tatooine。

---

讓我們來回顧：

```elm
type Msg
    = Fetch
    | FetchSuccess String
    | FetchError Http.Error
```

這裡有三個訊息。

- `Fetch` 初始一個到 API 的請求
- `FetchSuccess` 成功從 API 擷取回應。
- `FetchError` 無法從 API 擷取回應或無法剖析取回的回應。.

### Json 解碼器

```elm
decode : Decode.Decoder String
decode =
    Decode.at ["name"] Decode.string
```

上述程式碼新增一個解碼器給 API 擷取來的回應使用。建構解碼器可以使用[這個工具](http://noredink.github.io/json-to-elm/)，十分有用。

### 任務

```elm
fetchTask : Task Http.Error String
fetchTask =
    Http.get decode url
```

`Http.get` 取用一個解碼器及一個網址，傳回一個任務。

### 擷取命令

```elm
fetchCmd : Cmd Msg
fetchCmd =
    Task.perform FetchError FetchSuccess fetchTask
```

使用 `Task.perform` 來轉換任務成命令。此函式要求：

- 失敗的訊息建構子
- 成功的訊息建構子
- 欲執行的任務

### 更新

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Fetch ->
            ( model, fetchCmd )

        FetchSuccess name ->
            ( name, Cmd.none )

        FetchError error ->
            ( toString error, Cmd.none )
```

更新函式中，初始化擷取會傳回擷取命令。以及 `FetchSuccess` 與 `FetchError` 的反應。

---

還有許多關於任務，值得一覽文件：<http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Task>
