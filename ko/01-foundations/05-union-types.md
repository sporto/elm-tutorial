# 유니언 타입

In Elm, __Union Types__ are used for many things as they are incredibly flexible. A union type looks like:
Elm 에서 __유니언 타입__ 은 매우 유연하여 아주 다양하게 사용됩니다. 유니언 타입은 이렇게 생겼습니다:

```elm
type Answer = Yes | No
```

`Answer` 는 `Yes` 이거나 `No` 입니다. 유니언 타입은 코드를 범용성 있게 만들어 줍니다. 가령 이렇게 선언된 함수는:

```elm
respond : Answer -> String
respond answer =
    ...
```

첫째 인자로 `Yes` 나 `No` 를 받을 수 있는 겁니다. (예: `respond Yes`)

Elm 에서 유니언 타입은 흔히 __태그__ (역주: 혹은 태그드 유니언) 라고도 부릅니다.

## 포함하기 (Payload)

유니언 타입은 관련된 정보를 포함할 수 있습니다:

```elm
type Answer = Yes | No | Other String
```

이 경우, `Other` 태그는 관련된 문자열 (String) 을 포함합니다. 다시 위 `respond` 를 이렇게 호출할 수 있습니다:

```elm
respond (Other "Hello")
```

괄호가 없으면 Elm 은 respond 에 두 인자를 전달하는 것으로 생각할 겁니다.

## 생성자 함수로서 사용

다시 `Other` 를 어떻게 사용했나 봅시다:

```elm
Other "Hello"
```

이는 `Other` 를 함수처럼 호출한 것과 비슷합니다. 유니언 타입은 함수처럼 동작합니다. 이런 타입이 있다면:

```elm
type Answer = Message Int String
```

`Message` 태그는 이런 식으로 사용합니다:

```elm
Message 1 "Hello"
```

다른 함수처럼 부분 적용도 가능합니다. 이것들은 해당 타입을 생성하는 함수로 이용되기에 보통 `생성자` 라고 부릅니다.

## 중첩하기

어떤 유니언 타입이 다른 유니언 타입에 '중첩' 되는 경우는 매우 흔합니다.

```elm
type OtherAnswer = DontKnow | Perhaps | Undecided

type Answer = Yes | No | Other OtherAnswer
```

이걸 아까의 (`Answer` 타입을 받는) `respond` 함수에 이렇게 사용할 수 있습니다:

```elm
respond (Other Perhaps)
```

## 타입 변수

타입 변수를 사용할 수도 있습니다:

```elm
type Answer a = Yes | No | Other a
```

이는 Int, String 등과 같이 사용 가능한 `Answer` 가 됩니다.

만약 respond 가 이러하다면:

```elm
respond : Answer Int -> String
respond answer =
    ...
```

`Answer Int` 시그내쳐를 사용해서 `a` 자리에 `Int` 를 사용하겠다고 말하는 것입니다.

이후 respond 를 이렇게 호출 가능합니다:

```elm
respond (Other 123)
```

하지만 `respond (Other "Hello")` 는 실패하는데, 그것은 `respond` 가 `a` 의 자리에는 정수가 올 것으로 기대하기 때문입니다.

## 쓰임새

유니언 타입이 자주 쓰이는 경우 중 하나가 몇가지 가능한 경우 중 하나의 값을 프로그램 안에서 주고받는 때 입니다.

웬만한 웹 애플리케이션에는 유저를 불러오고, 추가하고, 삭제하는 등의 기능이 있습니다. 이런 기능 중 몇몇은 다른 데이터를 포함하기도 합니다.

그럴 때 이런 식으로 유니언 타입이 사용됩니다:

```elm
type Action
    = LoadUsers
    | AddUser
    | EditUser UserId
    ...

```

---

유니언 타입에 대해 더 많이 알고 싶다면 [여기](http://elm-lang.org/guide/model-the-problem)를 읽어보세요.
