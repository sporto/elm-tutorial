# ユニット型

空のタプル`()`はElmでは__ユニット型__と呼ばれます。一般的なので説明が必要でしょう。

`a`で表される__型変数__を持つ型エイリアスを考えてみましょう：

```elm
type alias Message a =
    { code : String
    , body : a
    }
```

このように `body`が`String`である`Message`を期待する関数を作ることができます：

```elm
readMessage : Message String -> String
readMessage message =
    ...
```

または `body`が整数のリストであるような`Message`を期待する関数も書けます：

```elm
readMessage : Message (List Int) -> String
readMessage message =
    ...
```

しかし、bodyに値を必要としない関数はどうでしょう？その場合、bodyが空であることを示すために、ユニット型を使用します。

```elm
readMessage : Message () -> String
readMessage message =
    ...
```

この関数は、__空のbody__を持つ `Message`をとります。これは__任意の値__ではなく、__空の値__と同じです。

このように、ユニット型は通常、空の値の代わりとして使用されます。

## タスク

`Task`型でのユニット型の使用例を見てみましょう。`Task`を使う場合、ユニット型を頻繁に使用します。

典型的なタスクは__エラー__と__結果__を持ちます。

```elm
Task error result
```

- エラーを安全に無視できるタスクが必要な場合があります： `Task () result`
- あるいは、結果を無視する場合： `Task error ()`
- またはその両方を無視する場合： `Task () ()`
