# Html.App 的結構

### 匯入

```elm
import Html exposing (Html, div, text)
import Html.App
```

- 我們使用 `Html` 模組內的 `Html` 型別，以及 `div` 與 `text` 函式。
- 另外匯入 `Html.App`，這就像個黏著劑，用來策劃安排我們的應用程式。這與 Elm 0.16 的 StartApp 相同。

### 模型（Model）

```elm
type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )
```

- 首先，我們定義應用程式模型為一種型別別名。這個例子只有一個 `String`。
- 接著，我們定義 `init` 函式。此函式提供給應用程式一個初始值。

__Html.App__ 預期收到一個 tuple `(model, command)`。第一個元素是初始狀態，例如："Hello"。第二個元素是要執行的初始命令。稍候會作解釋。

當使用 Elm 架構時，我們會組合所有元件的模型成為單一狀態樹（single state tree）。稍候會作解釋。

### 訊息（Messages）

```elm
type Msg
    = NoOp
```

訊息是一種會發生在應用程式內，元件需要回應的事情。這個例子中，應用程式不需要作任何事，所以只有一個 `NoOp` 訊息。

舉例來說，`Expand` 或 `Collapse` 訊息分別用來顯示及隱藏小工具（widget）。我們可以用聯集型別來定義訊息：

```elm
type Msg
    = Expand
    | Collapse
```

### 視界（View）

```elm
view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

`view` 函式用應用程式的模型轉譯（render）出一個 Html 元素。注意到型別標記式是 `Html Msg`。這表示此 Html 元素產出 Msg 訊息標籤（messages tagged）。稍候介紹某些互動時會看到這個。

### 更新（Update）

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

接下來，我們定義 `update` 函式，此函式將會被 Html.App 所呼叫，每當收到訊息時，便會執行此函式。此更新函式對訊息做出反應，需要時更動模型並傳回命令（commands）。

這個例子中，我們只對 `NoOp` 訊息做出反應，傳回未經更動的模型及 `Cmd.none` 命令（表示沒有命令需執行）。

### 訂閱（Subscriptions）

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
```

訂閱是在我們應用程式內，用來監聽外部輸入（external input）。例如：

- 滑鼠活動
- 鍵盤事件
- 瀏覽器的網址更動

這個例子中，沒有興趣於外部輸入，所以這裡使用 `Sub.none`。注意到型別標記式為 `Sub Msg`。元件內的訂閱都必須是相同型別。

### 主程式（Main）

```elm
main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

最後，`Html.App.program` 將所有東西接在一起，傳回可以轉譯到頁面的 html 元素。`program` 使用
`init`、`view`、`update` 及 `subscriptions`。
