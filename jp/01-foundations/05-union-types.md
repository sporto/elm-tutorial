# ユニオン型

Elmでは、__ユニオン型__は信じられないほど柔軟性があるため、多くのものに使用されています。ユニオン型は次のようになります。

```elm
type Answer = Yes | No
```

`Answer`は`Yes`または `No`のいずれかです。ユニオン型は、コードをより一般的なものにするのに便利です。たとえば、

```elm
respond : Answer -> String
respond answer =
    ...
```

ように宣言された関数respondは最初の引数として `Yes`または`No`を取るこ​​とができます。たとえば「respond Yes」は有効な呼び出しです。

Elmでは、ユニオン型は__タグ__と呼ばれることもあります。

## ペイロード

ユニオン型は、関連する情報を持つことができます。

```elm
type Answer = Yes | No | Other String
```

この場合、タグ「Other」には文字列が紐付けられ、次のように`respond`を呼び出すことができます：

```elm
respond (Other "Hello")
```

この場合括弧が必要です。さもなければElmはこれを2つの引数を渡して応答すると解釈してしまいます。

## コンストラクタ関数として

ペイロードを「Other」に持たせる方法に注意してください。

```elm
Other "Hello"
```

これは `Other`が関数であるときの関数呼び出しと同じです。ユニオン型は関数と同様に動作します。たとえば、以下のような型があるとき、

```elm
type Answer = Message Int String
```

次のようにして `Message`タグを作成します：

```elm
Message 1 "Hello"
```

他の関数と同様に部分適用も可能です。
これらは一般的に `コンストラクタ`と呼ばれ、これを使って完全な型を作ることができます。たとえば、関数`Message`を使って`(Message 1 "Hello")`を構築することができます。

## ユニオン型の入れ子

ユニオン型を他の型の中に入れ子にすることは非常に一般的です。

```elm
type OtherAnswer = DontKnow | Perhaps | Undecided

type Answer = Yes | No | Other OtherAnswer
```

これを例えば、引数に`Answer`型を取る`respond`関数に渡すことができます：

```elm
respond (Other Perhaps)
```

## 型変数

型変数(もしくはスタンドイン)を使うこともできます：

```elm
type Answer a = Yes | No | Other a
```

これは、たとえばIntやStringなどの異なる型でも使用できる `Answer`です。

これを使って関数`respond`を次のように定義できます。

```elm
respond : Answer Int -> String
respond answer =
    ...
```

ここでは、 `a`スタンドインは、`Answer Int`シグネチャによって「`Int`型でなければならない」と言っています。

なので、以下のように`respond`を呼ぶことができます：

```elm
respond (Other 123)
```

しかし、 `respond`は`a`として整数を期待するので、 `respond (Other "Hello")`はコンパイルエラーとなります。
(訳注: 「respond: Anwer a -> String」のようにジェネリックなままで関数を定義することもできます。)

## 一般的な使用方法

ユニオン型の典型的な使い方は、プログラム内の値を渡すことです。この値は、既知の可能な値のセットの1つになります。

例えば、典型的なウェブアプリケーションでの実行可能なアクションとして、ユーザーの追加、ユーザーの追加、ユーザーの削除などがあるとします。これらのアクションのいくつかはペイロードを持ちます。

このとき、ユニオン型を使用するのが一般的です。

```elm
type Action
    = LoadUsers
    | AddUser
    | EditUser UserId
    ...

```

---

ユニオン型については他にも多くの話題があります。興味があれば[こちら](http://elm-lang.org/guide/model-the-problem)をご覧ください。
