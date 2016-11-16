# 單位型別（The unit type）

Elm 中，空的 tuple `()` 稱之為__單位型別__。這個十分的普及，值得作些解說。

考慮某一個型別別名，並帶有__型別變數__（使用 `a` 代表）：

```elm
type alias Message a =
    { code : String
    , body : a
    }
```

可以讓某個函式預期有個 `Message` 型別，裡面的 `body` 是 `String` 型別，像是：

```elm
readMessage : Message String -> String
readMessage message =
    ...
```

或某個函式預期有個 `Message` 型別，裡面的 `body` 是整數串列的型別：

```elm
readMessage : Message (List Int) -> String
readMessage message =
    ...
```

但如果某個函式並不需要 body 有值呢？可以使用單位型別來指出 body 必須為空值：

```elm
readMessage : Message () -> String
readMessage message =
    ...
```

上述函式取用 `Message` 型別，帶有__空的 body__。這跟__任意值__不同，就是個__空__值。

所以，單位型別常見用來作為空值的保留位置（placeholder）。

## 任務（Task）

實際應用中 `Task` 型別就是個範例。當使用 `Task` 時，你會常看到單位型別。

典型的任務會有 __錯誤__ 及 __結果__。

```elm
Task error result
```

- 有時候，我們想要一種任務可以忽略錯誤：`Task () result`
- 或者，可以忽略結果：`Tasks error ()`
- 又或者，兩者皆可忽略：`Task () ()`
