# 匯入（Imports）與模組（Modules）

Elm 匯入模組使用 `import` 關鍵字，例如：

```elm
import Html
```

這從核心中匯入了 `Html` 模組。接著，可以用完整資格修飾路徑（fully qualified path）來使用這個模組的函式及型別。

```elm
Html.div [] []
```

也可以匯入模組的特定函式或型別：

```elm
import Html exposing (div)
```

`div` 被混合到目前作用域（scope）之中。你可以直接使用：

```elm
div [] []
```

你甚至可以將模組的所有東西匯出：

```elm
import Html exposing (..)
```

這樣就可以直接用模組所有的函式及型別。但在大多情況下並不建議這樣使用，最終造成歧異或模組之間的衝突。

## 模組與型別相同名稱

許多模組會匯出與其模組名稱相同的型別。例如，`Html` 模組有個 `Html` 型別，`Task` 模組有個 `Task` 型別。

下列函式傳回 `Html` 元素：

```elm
import Html

myFunction : Html.Html
myFunction =
    ...
```

同等於：

```elm
import Html exposing (Html)

myFunction : Html
myFunction =
    ...
```

第一個例子只匯入 `Html` 模組並使用完整資格修飾路徑 `Html.Html`。

第二個例子從 `Html` 模組中匯出 `Html` 型別。直接使用 `Html` 型別。

## 模組宣告

當你新建一個模組，需要在檔案最上方加入 `module` 宣告：

```elm
module Main exposing (..)
```

`Main` 是模組名稱。`exposing (..)` 表示匯出模組中所有函式及型別。Elm 預期檔案名稱為 __Main.elm__，換言之，檔案名稱與模組名稱相同。

應用程式可以有深層檔案結構。例如，__Players/Utils.elm__ 檔案的模組宣告為：

```elm
module Players.Utils exposing (..)
```

應用程式其他地方可以用下列語句匯入該模組：

```elm
import Players.Utils
```
