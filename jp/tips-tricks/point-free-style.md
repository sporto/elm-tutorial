# ポイントフリースタイル

ポイントフリーとは、体の中の1つ以上の引数を省略した関数を書くスタイルです。これを理解するために例を見てみましょう。

以下は、数値に10を加える関数です：


```elm
add10 : Int -> Int
add10 x =
    10 + x
```

接頭辞記法を使って `+`を使ってこれを書き直すことができます：

```elm
add10 : Int -> Int
add10 x =
    (+) 10 x
```

この場合の引数`x`は厳密には必要ではないので、次のように書き直すことができます：

```elm
add10 : Int -> Int
add10 =
    (+) 10
```


`x'が` add10`への入力引数と `+`への引数の両方としてどのように除去されたかに注意してください。`add10`は結果を計算するために整数と整数を必要とする関数のままです。このように引数を省略することを、__ポイントフリースタイル__と呼びます。

## いくつかの例

```elm
select : Int -> List Int -> List Int 
select num list =
    List.filter (\x -> x < num) list

select 4 [1, 2, 3, 4, 5] == [1, 2, 3]
```

は以下と同じです:

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

は以下と同じです:

```elm
process : List Int -> List Int 
process =
    reverse >> drop 3
```

