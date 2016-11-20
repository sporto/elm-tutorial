# 型エイリアス

Elmの__型エイリアス__は、その名前のとおり型に対する別名です。例えば、Elmでは、coreに`Int`型と`String`型がありますが、これらに別名をつけることができます：

```elm
type alias PlayerId = Int

type alias PlayerName = String
```

他のcoreの型を単純に指し示す2つの型エイリアスを作成することで、以下のような関数を書く代わりに：

```elm
label: Int -> String
```

次のように書くことができます：

```elm
label: PlayerId -> PlayerName
```

こうすることで、関数の処理がはるかに明確になります。

## レコード

Elmのレコード定義は次のようになります。

```elm
{ id : Int
, name : String
}
```

レコードを直接引数に取る関数の場合、次のようなシグネチャを書かなければならないでしょう：

```elm
label: { id : Int, name : String } -> String
```

これだとかなり冗長ですが、型エイリアスを使うことで以下のように書けます：

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
label: Player -> String
```

ここでは、レコード定義を指す `Player`型エイリアスを作成しています。次に、その型名を関数シグネチャに使用しています。

## コンストラクタ

レコードに対する型エイリアス名は__コンストラクタ__関数として使用できます。つまり型エイリアスを関数として使用し、レコードの値を作成できます。

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
Player 1 "Sam"
==> { id = 1, name = "Sam" }
```

ここでは `Player`型エイリアスを作成し、次に2つのパラメータを持つ関数として `Player`を呼び出します。これにより、適切な属性を持つレコードが返されます。引数の順序によって、どの値がどの属性に割り当てられるかが決まることに注意してください。
