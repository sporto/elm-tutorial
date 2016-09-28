# 聯集型別（Union types）

Elm 中，__聯集型別__非常地彈性並廣泛在許多地方。聯集型別看起來像是：

```elm
type Answer = Yes | No
```

`Answer` 可以是 `Yes` 或 `No`。聯集型別非常有用，讓程式碼更加泛用。舉例來說，函式可以定義成：

```elm
respond : Answer -> String
respond answer =
    ...
```

第一個引數接受 `Yes` 或 `No`，例如 `respond Yes` 就是個合法呼叫。

聯集型別通常也稱之為__標籤（tags）__。

## 裝載（Payload）

聯集型別可以附屬額外的訊息：

```elm
type Answer = Yes | No | Other String
```

上述例子中，`Other` 標籤有個附屬字串。你可以像這樣呼叫 `respond`：

```elm
respond (Other "Hello")
```

這裡要用括號包起來，不然 Elm 會當作傳遞 2 個參數到 `respond` 函數。

## 如同函式建構子

注意到我們如何裝載 `Other`：

```elm
Other "Hello"
```

就只是個函式呼叫，而 `Other` 是個函式。聯集型別表現像是函式。舉例來說，給定某型別：

```elm
type Answer = Message Int String
```

你可以用下列語法新增 `Message` 標籤：

```elm
Message 1 "Hello"
```

你也可以相其他函式一樣使用套用函式。通常稱之為 `建構子（constructors）`，因為你用這個方式來建構完整的型別，換言之，使用 `Message` 作為函式來建構 `(Message 1 "Hello")`。

## 巢狀

聯集型別用巢狀引用其他聯集型別十分常見。

```elm
type OtherAnswer = DontKnow | Perhaps | Undecided

type Answer = Yes | No | Other OtherAnswer
```

這樣你就可以傳遞到 `respond` 函式（預期 `Answer`），像是：

```elm
respond (Other Perhaps)
```

## 型別變數（Type variables）

你也可能需要用到型別變數或替身（stand-ins）

```elm
type Answer a = Yes | No | Other a
```

`Answer` 就可以使用不同的型別，例如 Int、String。

舉例來說，`respond` 可能看起來像是：

```elm
respond : Answer Int -> String
respond answer =
    ...
```

透過使用 `Answer Int` 標記式，表示 `a` 為型別 `Int` 的替身。

所以當我們需要呼叫 `respond` 時，語句為：

```elm
respond (Other 123)
```

但是，`(Other "Hello")` 語句則會失效，因為 `respond` 預期 `a` 的位置是個整數。

## 常見用法

一個常見的用法是，使用聯集型別來互相傳遞資料，這樣就可以知道可能的型別值。

舉理來說，典型的網頁應用程式中，包含了許多動作，例如：讀取使用者、新增使用者、刪除使用者⋯等。某些動作可能會裝載其他資料。

聯集型別常見用法為：

```elm
type Action
    = LoadUsers
    | AddUser
    | EditUser UserId
    ...

```

---

聯集型別還有更多細節。如果有興趣請參考[這裡](http://elm-lang.org/guide/model-the-problem)。
