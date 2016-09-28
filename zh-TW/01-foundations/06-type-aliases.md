# 型別別名（aliases）

顧名思義，型別別名一種別名功能。舉例來說，Elm 核心有 `Int` 及 `String` 兩種型別。你可以為它們新增別名：

```elm
type alias PlayerId = Int

type alias PlayerName = String
```

上述中新增了幾個型別別名，單純指到別的核心型別。這個十分有用，當函式看起來像是：

```elm
label: Int -> String
```

你可以寫成：

```elm
label: PlayerId -> PlayerName
```

這樣一來，函式更加清楚明瞭。

## 紀錄（Records）

紀錄定義看起來像是：

```elm
{ id : Int
, name : String
}
```

如果你希望函式使用紀錄，你可以像這樣撰寫標記式：

```elm
label: { id : Int, name : String } -> String
```

有點冗長，型別別名這時候就十分有幫助：

```elm
type alias Player =
    { id : Int
    , name : String
    }

label: Player -> String
```

上述新增 `Player` 型別別名，指到一個紀錄的定義。接著在函式標記式使用。

## 建構子（Constructors）

型別別名也可以作為__建構子__函式。表示我們也可以把型別別名當作函式一樣使用，用來新增實際的紀錄。

```elm
type alias Player =
    { id : Int
    , name : String
    }

Player 1 "Sam"
==> { id = 1, name = "Sam" }
```

上述新增 `Player` 型別別名。接著，呼叫 `Player` 型別別名，就如同函式一般，帶入兩個參數。這會傳回一個紀錄並帶有適當的屬性。注意到參數的順序決定了哪個屬性該有什麼值。
