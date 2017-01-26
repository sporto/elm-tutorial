# 포인트 프리 스타일

포인트 프리 스타일이란 함수의 인자를 하나 혹은 그 이상 생략하는 방식을 말합니다. 이해를 위해 예시를 봅시다.

전달된 숫자에 10 을 더하는 함수가 있습니다:

```elm
add10 : Int -> Int
add10 x =
    10 + x
```

`+` 을 전위 연산으로 옮겨 쓸 수 있습니다:

```elm
add10 : Int -> Int
add10 x =
    (+) 10 x
```

이제 인자 `x` 는 생략 가능합니다. 이렇게 쓸 수 있습니다:

```elm
add10 : Int -> Int
add10 =
    (+) 10
```

`x` 가 `add10` 의 인자와 `+` 연산 두 군데에서 빠진 것을 보세요. `add10` 은 여전히 결과 계산을 위해 정수 인자가 필요합니다. 이렇게 인자를 생략하는 것을 __포인트 프리 스타일__ 이라 부릅니다.

## 더 많은 예제들

```elm
select : Int -> List Int -> List Int
select num list =
    List.filter (\x -> x < num) list

select 4 [1, 2, 3, 4, 5] == [1, 2, 3]
```

는 아래와 같습니다:

```elm
select : Int -> List Int -> List Int
select num =
    List.filter (\x -> x < num)

select 4 [1, 2, 3, 4, 5] == [1, 2, 3]
```

---

```elm
process : List Int -> List Int
process list =
    reverse list |> drop 3
```

는 아래와 같습니다:

```elm
process : List Int -> List Int
process =
    reverse >> drop 3
```
