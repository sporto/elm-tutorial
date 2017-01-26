> This page covers Elm 0.18

# Html.program 의 구조

### 임포트

```elm
import Html exposing (Html, div, text, program)
```

- `Html` 모듈에서 `Html` 타입, `div`, `text`, `program` 함수를 임포트합니다.

### 모델

```elm
type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )
```

- 우선 앱의 모델을 타입 앨리어스로 선언했고, 이 경우는 `String` 입니다.
- 그 후 `init` 함수를 만듭니다. 앱의 초기 상태를 정하는 함수입니다.

__Html.program__ 는 `(model, command)` 튜플을 인자로 받습니다. 튜플의 첫 속성은 초기 상태이며 (예: "Hello"), 두번째 속성은 처음 전달할 커맨드입니다. 이는 나중에 다루겠습니다.

Elm 아키텍쳐에서는, 모든 컴포넌트의 모델을 조합하여 트리 구조를 가진 단 하나의 상태로 보관합니다. 이 또한 뒤에서 설명합니다.

### 메시지

```elm
type Msg
    = NoOp
```

Messages 는 앱에서 각 컴포넌트에게 요청되는 것들입니다. 이 앱은 딱히 하는 일이 없어서, `NoOp` 이라는 메시지 하나만 만들어 놓았습니다.

예를 들면 `Expand` 나 `Collapse` 라는 식으로 위젯을 펼치거나 숨기도록 하는 메시지를 만들 수 있습니다. 메시지는 유니언 타입을 사용합니다:

```elm
type Msg
    = Expand
    | Collapse
```

### 뷰

```elm
view : Model -> Html Msg
view model =
    div []
        [ text model ]
```

`view` 함수는 앱의 모델을 전달받아 Html 엘리먼트를 만듭니다. 타입 시그내쳐 `Html Msg` 를 봐 주세요. 이는 이 Html 엘리먼트가 Msg 타입의 메시지를 생성할 수 있다는 이야기입니다. 이후 상호작용 관련해서 다시 보게 될 내용입니다.

### 업데이트

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )
```

다음은 `update` 함수로, 메시지가 발생할 때마다 `Html.program` 로부터 호출됩니다. 이 함수에서는 각 메시지에 대응해 갱신된 모델이나 커맨드를 리턴합니다.

여기서는 `NoOp` 메시지에 대응해 변경되지 않은 모델과 `Cmd.none` (커맨드 없음) 을 리턴하고 있습니다.

### 서브스크립션

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
```

서브스크립션은 앱 외부로부터 전달되는 입력을 받기 위한 것입니다. 예를 들면 이런 경우죠:

- 마우스 동작
- 키보드 이벤트
- 브라우저 주소 변경

현재는 어떤 외부 입력도 처리하지 않을 것이므로 `Sub.none` 입니다.

### Main

```elm
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

최종적으로 `Html.program` 에서 모두를 묶고 html 엘리먼트를 리턴합니다. `program` 함수는 위에서 작성한 `init`, `view`, `update`, `subscriptions` 함수를 전달받고 있습니다.






 
