# 應用程式流（Application flow）

下圖描繪出 Html.App 如何與應用程式交互作用。

![Flow](04-flow.png)

1. Html.App 使用初始模型及 view 函式來轉譯。
1. 當使用者點擊 Expand 按鈕，視界觸發 `Expand` 訊息。
1. Html.App 收到 `Expand` 訊息，呼叫 `update` 函式帶入 `Expand` 訊息以及目前應用程式的狀態
1. update 函式回應訊息，傳回更新後狀態及要執行的命令（或者 `Cmd.none`）。
1. Html.App 收到更新後狀態，儲存，呼叫 view 函式帶入更新後狀態。

通常 Html.App 是 Elm 應用程式唯一持有狀態的地方，它是一個集中的大棵狀態樹。
