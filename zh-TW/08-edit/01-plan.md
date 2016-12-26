# 規劃

更改某個玩家等級的計畫如下：

![Flow](01-plan.png)

(1) 當使用者點擊增加或減少的按鈕，觸發 `ChangeLevel` 訊息並伴隨著 `playerId` 及 `howMuch`。

(2) __Html.App__ （由 Navigation 包裝 ）將發送訊息回到 `Main.Update` 進而轉送到 `Players.Update` (3)。

(4) `Players.Update` 將傳回命令來儲存玩家，此命令往上傳遞到 __Html.App__ (5)。

(6) Elm 執行期執行命令（觸發 API 呼叫）並得到成功或失敗的結果。若成功將會觸發 `SaveSuccess` 訊息並伴隨著更新後的玩家。

(7) `Main.Update` 路由 `SaveSuccess` 訊息至 `Players.Update`。

(8) 在 `Players.Update` 中，更新 `players` 模型並傳回。流回到 Html.App (9)。

(10) 接著 Html.App 使用更新後的模型渲染應用程式。
