# Hello World

## 安裝 Elm

前往 http://elm-lang.org/install 並下載適合你作業系統的安裝程序。

## 第一個 Elm 應用程式

讓我們開始撰寫第一個 Elm 應用程式。首先建立一個資料夾。開啟終端機，在新建的資料夾下執行：

```bash
elm package install elm-lang/html
```

這會安裝 _html_ 模組。接增新增 `Hello.elm` 檔案，輸入下列程式碼：

```elm
module Hello exposing (..)

import Html exposing (text)


main =
    text "Hello"
```

接著在終端機輸入並執行：

```bash
elm reactor
```

畫面顯示：

```
elm reactor 0.18.0
Listening on http://0.0.0.0:8000/
```

開啟瀏覽器並進入網址 `http://0.0.0.0:8000/`，點擊 `Hello.elm`。你會看見瀏覽器顯示 `Hello` 字串。

注意，你或許會看見警告，關於 `main` 缺少型別註解（type annotation）。暫時忽略它，稍候會介紹型別註解。

讓我們回顧剛剛發生了什麼事：

### 模組宣告

```
module Hello exposing (..)
```

Elm 每個模組開頭都必須是模組宣告，此例中的模組名稱為 `Hello`。慣例上檔名與模組名稱會是相同的。例如 `Hello.elm` 包含 `module Hello` 模組。

宣告的 `exposing (..)` 明確指出哪些函式、型別要被揭露給其他模組匯入。此例揭露了所有東西 `(..)`。

### 匯入

```
import Html exposing (text)
```

若要在 Elm 中使用__模組__，必須明確地匯入模組。此例明確匯入 __Html__ 模組。

此模組有許多與 HTML 有關的函式。我們使用 `.text` 函式，因此使用 `exposing` 將該函式匯入到目前的命名空間（namespace）。

### 主程式（Main）

```
main =
    text "Hello"
```

Elm 的前端應用程式是從 `main` 函式作為起始點。`main` 函式傳回元素（element）並描繪在頁面之中。此例傳回 Html 元素（用 `text` 所產生）。

### Elm reactor

Elm __reactor__ 啟動一個能夠即時編譯 Elm 的伺服器。對於開發 __reactor__ 十分好用，無須煩惱設定建置流程。然而，__reactor__ 有其限制，因此後面章節將改用一個建置流程。
