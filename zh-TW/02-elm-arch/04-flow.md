# 應用程式流（Application flow）

下圖描繪出 Html.App 如何與應用程式交互作用。

![Flow](04-flow.png)

1. Html.App 呼叫視界函式並帶入初始模型進行轉譯。
1. 當使用者點擊 Expand 按鈕，視界觸發 `Expand` 訊息。
1. Html.App 收到 `Expand` 訊息，呼叫 `更新` 函式帶入 `Expand` 訊息及目前應用程式的狀態
1. 更新函式回應訊息，傳回更新後狀態及欲執行的命令（或 `Cmd.none`）。
1. Html.App 收到更新後狀態，儲存，呼叫視界函式並帶入更新後狀態。

通常 Html.App 是 Elm 應用程式唯一持有狀態的地方，它是一個集中的大型狀態樹。
