# 型別別名（aliases）

顧名思義型別別名是一種別名功能。舉例來說，Elm 核心有 `Int` 及 `String` 兩種型別。你可以為它們新增別名：

```elm
type alias PlayerId = Int

type alias PlayerName = String
```

上述幾個別名單純指名別的核心型別。像是下述函式，特別有用：

```elm
label: Int -> String
```

可以改寫成：

```elm
label: PlayerId -> PlayerName
```

這樣的函式更加清楚、明瞭。

## 紀錄（Records）

紀錄定義式看起來像是：

```elm
{ id : Int
, name : String
}
```

如果你想在函式使用紀錄，可以這樣撰寫標記式：

```elm
label: { id : Int, name : String } -> String
```

有些冗長，這時候型別別名就很有用：

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
label: Player -> String
```

新增一個 `Player` 型別別名，指到一個紀錄定義式。接著在函式標記式使用這個別名。

## 建構子（Constructors）

型別別名也可以用來當作__建構子__函式使用。可以把型別別名當作函式一樣使用，建立出紀錄。

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
Player 1 "Sam"
==> { id = 1, name = "Sam" }
```

上述新增一個 `Player` 型別別名。接著，如同函式一般呼叫 `Player` 型別別名，帶入兩個參數。這會傳回一個紀錄並帶有適當的屬性。請注意到，參數的先後順序決定哪個屬性有的值。
