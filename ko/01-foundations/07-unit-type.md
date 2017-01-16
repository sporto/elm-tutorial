# 유닛 타입

빈 튜플 `()` 은 Elm 에서 __유닛 타입__ 이라 부릅니다. 이는 설명이 조금 필요합니다.

__타입 변수__ (`a` 로 표현되는) 를 가진 타입 앨리어스가 있습니다:

```elm
type alias Message a =
    { code : String
    , body : a
    }
```

`body` 를 `String` 으로 갖는 `Message` 는 이렇게 만듭니다:

```elm
readMessage : Message String -> String
readMessage message =
    ...
```

`body` 를 정수 (Int) 의 리스트 (List) 로 가지려면 이렇게 만들면 됩니다:

```elm
readMessage : Message (List Int) -> String
readMessage message =
    ...
```

body 의 값이 필요하지 않은 경우는 어떨까요? body 가 어떤 값도 아니라는 뜻으로 유닛 타입을 사용합니다:

```elm
readMessage : Message () -> String
readMessage message =
    ...
```

이 함수는 __빈 body__ 를 가진 `Message` 입니다. __아무 값__ 이 아니라, __비어있는__ 겁니다.

따라서 빈 값을 표현하는 데 유닛 타입이 흔히 사용된다고 볼 수 있습니다.

## Task 타입

하나의 실전 예시는 `Task` 타입입니다. 여러분이 `Task` 를 쓰게 되면, 유닛 타입을 정말 자주 보게 될겁니다.

보통 Task 는 __error__ 와 __result__ 를 가집니다:

```elm
Task error result
```

- 가끔은 에러가 무시되어도 상관없는 경우가 있죠: `Task () result`
- 아니면 결과를 무시하거나: `Task error ()`
- 둘 다일때도 있습니다: `Task () ()`
