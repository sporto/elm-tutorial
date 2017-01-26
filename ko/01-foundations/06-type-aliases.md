# 타입 앨리어스 (Type aliases)

Elm 에서 __타입 앨리어스__ 란, 이름 그대로, 다른 무언가를 가리키는 별명입니다. Elm 에는 핵심 타입 `Int` 와 `String` 이 있는데, 이렇게 앨리어스를 붙일 수 있습니다:

```elm
type alias PlayerId = Int

type alias PlayerName = String
```

다른 핵심 타입을 가리키는 단순한 타입 앨리어스를 만들었습니다. 그래도 이런 함수를:

```elm
label: Int -> String
```

이렇게 표현할 수 있다는 데서 유용합니다:

```elm
label: PlayerId -> PlayerName
```

덕분에 함수가 요구하는 것이 명확해 집니다.

## 레코드

Elm 의 레코드는 이런 식입니다:

```elm
{ id : Int
, name : String
}
```

레코드를 인자로 받는 함수를 만드려면, 이런 식으로 시그내쳐를 써야겠네요:

```elm
label: { id : Int, name : String } -> String
```

정말 복잡합니다. 하지만 타입 앨리어스로 이렇게 쓸 수 있습니다:

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
label: Player -> String
```

레코드 정의를 가리키는 `Player` 타입 앨리어스를 만들었고, 함수 시그내쳐에 이를 사용했습니다.

## 생성자

타입 앨리어스는 __생성자__ 함수로 사용할 수 있습니다.

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
Player 1 "Sam"
==> { id = 1, name = "Sam" }
```

`Player` 타입 앨리어스를 만들고, `Player` 를 두 인자를 가진 함수처럼 사용했습니다. 레코드의 속성 순서와 함수의 인자 순서가 같다는 점을 알 수 있습니다.
