# インポートとモジュール

Elmでは、`import`キーワードを使用してモジュールをインポートします。

```elm
import Html
```

これは `Html`モジュールをインポートします。すると完全修飾パスを使用して、このモジュールの関数と型を使用できます。

```elm
Html.div [] []
```

また、モジュールをインポートして、そこから特定の関数と型をexposeすることもできます。

```elm
import Html exposing (div)
```

`div`は現在のスコープに導入され、直接使うことができます：

```elm
div [] []
```

モジュール内のすべてをexposeすることさえできます：

```elm
import Html exposing (..)
```

この場合、モジュール中のすべての関数と型を直接使用することができます。しかし、あいまいさやモジュール間の衝突の可能性があるため、これはほとんどの場合お勧めできません。

## モジュール名と同じ名前の型

多くのモジュールは、モジュールと同じ名前の型をエクスポートします。例えば、 `Html`モジュールは`Html`型を持ち、 `Task`モジュールは`Task`型を持っています。

この関数は `Html`要素を返します：

```elm
import Html

myFunction : Html.Html
myFunction =
    ...
```

上記は以下と等価です：

```elm
import Html exposing (Html)

myFunction : Html
myFunction =
    ...
```

最初の例は `Html`モジュールのみをインポートし、完全修飾パス`Html.Html`を使用します。

2番目の例では、 `Html`モジュールを`Html`モジュールからexposeしています。また、`Html`型を直接使用します。

## モジュールの宣言

elmでモジュールを作成するときは、最初に`module`宣言を追加します：

```elm
module Main exposing (..)
```

`Main`はモジュールの名前です。 `exposing(..)`は、このモジュールのすべての関数と型を公開することを意味します。 elmは、このモジュールを__Main.elm__というファイル、つまりモジュールと同じ名前のファイルで見つけることを想定しています。

アプリケーションにより深いファイル構成を持たせることができます。たとえば、ファイル__Players/Utils.elm__には次のような宣言が必要です。

```elm
module Players.Utils exposing (..)
```

アプリケーションのどこからでもこのモジュールをインポートすることができます：

```elm
import Players.Utils
```
