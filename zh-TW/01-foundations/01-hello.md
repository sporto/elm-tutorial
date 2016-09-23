# Hello World

## 安裝 Elm

前往 http://elm-lang.org/install 並下載適合你的作業系統的安裝程序。

## 第一個 Elm 應用程式

讓我們開始撰寫第一個 Elm 應用程式。首先建立一個資料夾。使用終端機在資料夾底下執行下列命令：

```bash
elm package install elm-lang/html
```

這將會安裝 _html_ 模組。接增新增 `Hello.elm` 檔案，輸入下列程式碼：

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

畫面會顯示：

```
elm reactor 0.17.0
Listening on http://0.0.0.0:8000/
```

開啟瀏覽器並進入網址 `http://0.0.0.0:8000/`，點選 `Hello.elm`。你會看見 `Hello` 字串。

注意，你或許會看見有關 `main` 缺少型別註解（type annotation）的警告。暫時忽略它，稍候會介紹到型別註解。

讓我們回顧剛剛發生了什麼事：

### 模組宣告

```
module Hello exposing (..)
```

Elm 每個模組開頭必須是模組宣告，此例中的模組名稱為 `Hello`。慣例上檔名與模組名稱會是相同的。例如 `Hello.elm` 包含 `module Hello`。

宣告中 `exposing (..)` 部份明確指出哪些函式、型別要被揭露給其他模組匯入使用。此例中揭露了所有東西 `(..)`。

### 匯入

```
import Html exposing (text)
```

若要在 Elm 中使用__模組__，必須明確地匯入模組。此例中使用了 __Html__ 模組。

此模組有許多與 HTML 有關的函式。我們使用了 `.text`，因此，使用 `exposing` 將函式匯入目前的命名空間（namespace）。

### 主程式

```
main =
    text "Hello"
```

Elm 前端應用程式從 `main` 函式作為起始。`main` 是個函式，回傳元素（element）並描繪在頁面之中。此例回傳 Html 元素（使用 `text` 所建立）。

### Elm reactor

Elm __reactor__ 建立出能夠編譯 Elm 程式碼的伺服器。__reactor__ 對於開發應用程式十分有用，無須煩惱如何配置建制流程。然而， __reactor__ 是有限制的，因此，稍候我們將需要配置出建制流程。
