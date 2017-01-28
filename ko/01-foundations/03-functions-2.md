# 함수 더 알아보기

## 타입 변수

어떤 함수가 다음 타입 시그내쳐를 가지고:

```elm
indexOf : String -> List String -> Int
```

문자열과 문자열 리스트를 인자로 받아 리스트 내에 인자로 전달된 문자열과 같은 것이 있으면 그 인덱스를, 없다면 -1 를 리턴하는 함수라고 가정합시다.

그런데 문자열이 아니라 정수 리스트를 가진 상황에선 이 함수를 쓰기 곤란하겠죠. 다행히 우리는 특정 타입 대신 __타입 변수__ 혹은 __스탠드-인__ 이라 불리는 기능을 써서 이 함수를 __범용적 (generic)__ 으로 만들 수 있습니다.

```elm
indexOf : a -> List a -> Int
```

`String` 을 `a` 로 바꾸면, 이 타입 시그내쳐는 타입 `a` 와 타입 `a` 의 리스트를 인자로 받고 정수를 리턴하는 함수 `indexOf` 라는 의미를 갖습니다. 타입 형태만 같다면 컴파일에는 문제가 없습니다. `String` 과 `String` 의 리스트로 호출하는 것도, `Int` 와 `Int` 의 리스트로 호출하는 것도 가능합니다.

범용성을 더 높일 수 있습니다. __타입 변수__ 를 여러개 써도 됩니다:

```elm
switch : ( a, b ) -> ( b, a )
switch ( x, y ) =
  ( y, x )
```

이 함수는 타입 `a`, `b` 로 이루어진 튜플을 받아 타입 `b`, `a` 의 튜플을 리턴합니다. 아래 전부 유효한 호출입니다:

```elm
switch (1, 2)
switch ("A", 2)
switch (1, ["B"])
```

타입 변수는 소문자로 써야 하고, `a` 나 `b` 등이 관례적으로 사용됩니다. 다음 형식도 충분히 가능합니다:

```
indexOf : thing -> List thing -> Int
```

## 인자로 전달되는 함수

이런 시그내쳐가 있을 때:

```elm
map : (Int -> String) -> List Int -> List String
```

이 함수는:

- 함수를 인자로 받고: `(Int -> String)` 부분
- 정수 리스트를 인자로 받으며
- 문자열 리스트를 리턴합니다.

흥미로운 부분은 `(Int -> String)` 으로, 인자로 전달받는 함수가 `(Int -> String)` 시그내쳐를 만족해야 한다는 이야기입니다.

코어 라이브러리의 `toString` 은 이를 만족하므로, `map` 함수에 사용 가능합니다:

```elm
map toString [1, 2, 3]
```

사실 `Int` 와 `String` 은 너무 제한적입니다. 대부분의 경우 타입 변수를 사용한 시그내쳐일 겁니다:

```elm
map : (a -> b) -> List a -> List b
```

`a` 타입 리스트를 `b` 타입 리스트로 매핑하는 함수입니다. 사실 첫 인자로 전달되는 함수와 사용되는 타입이 같느냐가 중요하지 `a` 와 `b` 가 어떤 타입인지가 중요한 것은 아닙니다.

그러면 이렇게 다양한 시그내쳐를 가진 함수들 모두를:

```elm
convertStringToInt : String -> Int
convertIntToString : Int -> String
convertBoolToInt : Bool -> Int
```

범용적으로 map 을 통해 사용 가능합니다:

```elm
map convertStringToInt ["Hello", "1"]
map convertIntToString [1, 2]
map convertBoolToInt [True, False]
```
