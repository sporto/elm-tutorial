# 單位型別（The unit type）

空的 tuple `()` 稱之為__單位型別__。十分的普及，普及到該做些解說。

考慮某型別別名，帶有__型別變數__（使用 `a` 代表）：

```elm
type alias Message a =
    { code : String
    , body : a
    }
```

你可以讓某個函式預期有個 `Message` 型別，裡面的 `body` 是個 `String` 型別，如下：

```elm
readMessage : Message String -> String
readMessage message =
    ...
```

或者某個函式預期有個 `Message` 型別，裡面的 `body` 是個整數串列的型別：

```elm
readMessage : Message (List Int) -> String
readMessage message =
    ...
```

但是，如果某個函式並不需要 body 的值呢？我們使用單位型別來指示該 body 必須為空：

```elm
readMessage : Message () -> String
readMessage message =
    ...
```

上述函式取用 `Message` 型別，裡面帶有__空的 body__。這跟__任意值__不同，就只是個__空__值。

所以，單位型別常見用來作為空值的保留位置（placeholder）。

## 任務（Task）

實際應用中，`Task` 型別就是個範例。當使用 `Task` 時，你將會常看到單位型別。

典型的任務包含__錯誤__及__結果__。

```elm
Task error result
```

- 有時候，我們想要一種任務，錯誤可以被放心的忽略：`Task () result`
- 或者，結果可以被忽略：`Tasks error ()`
- 又或者，兩者皆可忽略：`Task () ()`
