# 임포트와 모듈

Elm 에서는 아래와 같이 `import` 를 사용하여 모듈을 임포트합니다.

```elm
import Html
```

이렇게 `Html` 모듈을 임포트하는 경우 동일한 이름으로 모듈의 함수와 타입을 사용할 수 있습니다.

```elm
Html.div [] []
```

특정 함수나 타입만 명시할 수도 있습니다:

```elm
import Html exposing (div)
```

이 경우 `div` 는 현재 스코프에 포함됩니다. 모듈 이름 없이 사용할 수 있습니다:

```elm
div [] []
```

그냥 전부 가져올 수도 있고요:

```elm
import Html exposing (..)
```

이렇게 하면 모듈의 모든 함수와 타입을 모듈 이름 없이 사용할 수 있지만, 모듈 간 이름 충돌 문제가 따라오므로 추천하지는 않습니다.

## 같은 이름을 가진 모듈과 타입

많은 모듈이 모듈과 같은 이름의 타입을 익스포트합니다. `Html` 모듈의 `Html` 타입이나 `Task` 모듈의 `Task` 타입이 그 예입니다.

`Html` 엘리먼트를 리턴하는 이 함수는:

```elm
import Html

myFunction : Html.Html
myFunction =
    ...
```

이렇게 써도 동일합니다:

```elm
import Html exposing (Html)

myFunction : Html
myFunction =
    ...
```

첫 예시에서는 `Html` 모듈만 임포트했으므로 `Html.Html` 로 접근했죠.

두번째 예시에서는 `Html` 타입을 노출했으므로, 직접 사용했습니다.

## 모듈 선언

Elm 에서 모듈을 생성할 때는, 맨 위에 `module` 선언을 합니다:

```elm
module Main exposing (..)
```

`Main` 은 모듈의 이름입니다. `exposing (..)` 은 이 모듈의 모든 함수와 타입을 외부로 노출하겠다는 의미입니다. Elm 은 이 모듈을 __Main.elm__ 파일에서 찾으려고 할 것입니다. (모듈과 이름이 같기 때문에)

더 세세하게 구조를 나눌 수도 있습니다. 예를 들면, __Players/Utils.elm__ 파일은 이런 식입니다:

```elm
module Players.Utils exposing (..)
```

어플리케이션 어디에서나 이 모듈을 임포트 할 수 있습니다:

```elm
import Players.Utils
```




