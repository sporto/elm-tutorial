>このページでは、Elm 0.17

#  タスク

副作用を伴う活動から結果を収集するためにコマンドを使用する方法を見てきました。しかし、コマンドには成功または失敗という概念はありません。彼らはまた、逐次実行の概念も持ちません。コマンドは、実行しなければならないことを格納しているだけのものです。

Elmでは、成功もしくは失敗する可能性があり、逐次実行が必要な非同期操作に__タスク__を使用します。これをして、次にそれをしてください、というような処理です。それらはJavaScriptのPromiseと似ています。

タスクは、`Task errorValue successValue`というシグネチャを持ちます。第1引数はエラータイプで、第2引数は成功タイプです。例えば：

- `Task Http.Error String`はHttp.Errorで失敗するか、文字列で成功するタスクです。
- `Task Never Result`は決して失敗しないタスクであり、常に`Result`で成功します。

タスクは通常、非同期操作を実行する関数(例: HTTPリクエストの送信)から返されます。

## コマンドとの関係

ライブラリからタスクを取得するには、そのタスクをコマンドにラップして、__Html.App__にコマンドを送信する必要があります。

例を見て、まずいくつかの追加パッケージをインストールしてください：

```bash
elm package install evancz/elm-http
```

そして以下がアプリケーションです：

```elm
module Main exposing (..)

import Html exposing (Html, div, button, text)
import Html.Events exposing (onClick)
import Html.App
import Http
import Task exposing (Task)
import Json.Decode as Decode



-- モデル


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "", Cmd.none )



-- メッセージ


type Msg
    = Fetch
    | FetchSuccess String
    | FetchError Http.Error



-- VIEW


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



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = (always Sub.none)
        }

```

このアプリケーションは、swapi(Star Wars API)から惑星の名前を取得します。それは今のところ常に惑星Tatooineです。

---

あらためて見てみます。まず、

```elm
type Msg
    = Fetch
    | FetchSuccess String
    | FetchError Http.Error
```

3つのメッセージがあります。

- APIへのリクエストを開始するための `Fetch`
- APIからの応答が成功したときの `FetchSuccess`
- APIに到達しなかった場合、または返された応答を解析できなかった場合は、`FetchError`を返します。

### Jsonデコーダ

```elm
decode : Decode.Decoder String
decode =
    Decode.at ["name"] Decode.string
```

このコードは、APIから返されたJsonのデコーダを作成します。デコーダーを構築するために[このツール](http://noredink.github.io/json-to-elm/)は非常に有用です。

###  仕事

```elm
fetchTask : Task Http.Error String
fetchTask =
    Http.get decode url
```

`Http.get`はデコーダとURLを取り、タスクを返します。

### フェッチコマンド

```elm
fetchCmd : Cmd Msg
fetchCmd =
    Task.perform FetchError FetchSuccess fetchTask
```

`Task.perform`を使ってタスクをコマンドに変換します。この関数は以下を引数にとります:

- 失敗メッセージのコンストラクタ
- 成功メッセージのコンストラクタ
- 実行するタスク

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

更新では、フェッチを開始するときにfetchコマンドを返します。 `FetchSuccess`と`FetchError`に応答します。

---

タスクにはもっと多くのことがあります。<http://package.elm-lang.org/packages/elm-lang/core/4.0.1/Task>のドキュメントを参照するのは有用でしょう。

