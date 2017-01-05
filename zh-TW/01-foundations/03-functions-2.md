# 更多函式

## 型別變數（Type variables）

考慮下列函式標記式：

```elm
indexOf : String -> List String -> Int
```

假設函式取用一個字串及一個字串串列（list of strings），傳回索引位置，表示串列存在給定字串，若不存在則索引位置為 -1。

但是，如果搜尋對象是個整數串列（list of integers）呢？我們無法使用這個函式。然而，我們可以讓函式__一般化（generic）__，透過__型別變數__或__替身（stand-ins）__來代替指明型別。

```elm
indexOf : a -> List a -> Int
```

將 `String` 改成 `a`，現在標記式表示 `indexOf` 取得一個 `a` 任意型別的值，以及一個 `a` 任意型別的串列，傳回一個整數。只要型別符合，編譯器表示開心。你可以呼叫 `indexOf` 帶入一個 `String` 及 `String` 串列，或者一個 `Int` 及 `Int` 串列，沒有問題。

這樣一來函式可以更加一般化。函式也可以有多個__型別變數__：

```elm
switch : ( a, b ) -> ( b, a )
switch ( x, y ) =
  ( y, x )
```

此函式取得一個 tuple，裡面包含 `a` 與 `b` 型別，傳回一個 tuple，裡面包含 `b` 與 `a` 型別。這些都是有效的使用。

```elm
switch (1, 2)
switch ("A", 2)
switch (1, ["B"])
```

請注意，任意小寫識別字都可以用來作為型別變數，`a` 及 `b` 只是常見慣例用法。舉例來說，下列函式標記式完全有效：

```
indexOf : thing -> List thing -> Int
```

## 函式作為引數

考慮下列函式標記式：

```elm
map : (Int -> String) -> List Int -> List String
```

此函式：

- 取得一個函式：`(Int -> String)` 部份
- 一個整數串列
- 傳回字串串列

有趣的部份是 `(Int -> String)` 片段。這表示帶入的函式必須符合 `(Int -> String)` 標記式。

舉例來說，核心函式庫的 `toString` 就是如此。所以你可以呼叫 `map` 函式，例如：

```elm
map toString [1, 2, 3]
```

但是 `Int` 及 `String` 過於特定。所以大多數時候你會看到標記式使用替身來代替：

```elm
map : (a -> b) -> List a -> List b
```

此函式映射一個 `a` 型別串列到另一個 `b` 型別串列。實際上我們並不在乎 `a` 跟 `b` 代表什麼，只要第一個引數帶入的的函式使用相同的型別即可。

舉理來說，給定下列函式標記式：

```elm
convertStringToInt : String -> Int
convertIntToString : Int -> String
convertBoolToInt : Bool -> Int
```

我們可以呼叫一般化的 map 函式，例如：

```elm
map convertStringToInt ["Hello", "1"]
map convertIntToString [1, 2]
map convertBoolToInt [True, False]
```
