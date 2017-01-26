# Hello World

## Elm 설치

http://elm-lang.org/install 에서 여러분의 시스템에 적당한 인스톨러를 다운로드해 설치합니다.

## 첫 Elm 어플리케이션

우리의 첫 Elm 어플리케이션을 작성해 봅시다. 폴더를 하나 만듭니다. 터미널을 통해 폴더에서 아래 커맨드를 실행합니다:

```bash
elm package install elm-lang/html
```

_html_ 모듈이 설치됩니다. 이제 `Hello.elm` 파일을 추가하고, 아래와 같이 작성합니다:

```elm
module Hello exposing (..)

import Html exposing (text)


main =
    text "Hello"
```

터미널에서 다음과 같이 입력하면:

```bash
elm reactor
```

아래와 같이 출력됩니다:

```
elm reactor 0.18.0
Listening on http://0.0.0.0:8000/
```

브라우저로 `http://0.0.0.0:8000/` 를 열고 `Hello.elm` 를 클릭해 봅니다. `Hello` 를 볼 수 있습니다.

`main` 의 타입 어노테이션을 찾을 수 없다는 경고를 볼 수도 있어요. 지금은 무시하세요. 나중에 추가할 겁니다.

이제 무슨 일이 일어나고 있는지 볼까요:

### 모듈 선언

```
module Hello exposing (..)
```

Elm 의 각 모듈은 모듈 선언으로 시작해야 하며, 현재는 `Hello` 라는 이름을 가지고 있네요. 모듈과 파일 이름을 일치시키는 건 하나의 관례입니다. (예: `Hello.elm` 파일의 `module Hello`)

모듈 선언의 `exposing (..)` 부분은 이 모듈이 어떤 함수와 타입을 외부에 노출할 지 지정합니다. 위 `(..)` 와 같은 경우는 전부입니다.

### 임포트

```
import Html exposing (text)
```

Elm 에서는 여러분이 임포트할 모듈을 명시해야 합니다. 현재는 __Html__ 모듈을 사용하겠다는 것이죠.

이 모듈은 html 에 관한 많은 함수들을 가지고 있습니다. 우리는 `text` 함수를 사용할 것이고 `exposing` 을 통해 현재 네임스페이스로 임포트합니다.

### Main

```
main =
    text "Hello"
```

Elm 의 프론트엔드 애플리케이션은 `main` 으로 시작합니다. `main` 은 페이지에 그릴 엘리먼트를 리턴하는 함수입니다. 현재는 Html 엘리먼트를 리턴하고 있습니다. (`text` 로 생성한)

### Elm reactor

Elm __reactor__ 는 Elm 코드를 즉시 컴파일하는 서버를 생성합니다. __reactor__ 는 빌드 프로세스를 구성하는 데 크게 신경쓰지 않고 개발하는 상황에 적합합니다. 하지만 한계가 있으므로, 나중에 다른 빌드 프로세스로 바꿀 겁니다.
