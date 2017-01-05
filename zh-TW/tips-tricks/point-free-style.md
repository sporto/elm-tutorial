# Point free 風格

Point free 是一種撰寫函式的風格，此風格忽略內部一個或多個函數引述。透過範例來稍作了解。

這裡有個程式，對某個數值額外加上 10：

```elm
add10 : Int -> Int
add10 x =
    10 + x
```

可以使用 `+` 前墜標記法來改寫：

```elm
add10 : Int -> Int
add10 x =
    (+) 10 x
```

此例的函式引數 `x` 並非完全必要，可以改寫成：

```elm
add10 : Int -> Int
add10 =
    (+) 10
```

注意到函式引數的 `x` 以及 `+` 旁邊的 `x` 都消失了。`add10` 仍然是個函式，需要一個整數來計算結果。這樣的省略引數稱之為__point free 風格__。

## 更多範例

```elm
select : Int -> List Int -> List Int 
select num list =
    List.filter (\x -> x < num) list

select 4 [1, 2, 3, 4, 5] == [1, 2, 3]
```

相同於：

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

相同於：

```elm
process : List Int -> List Int 
process =
    reverse >> drop 3
```

