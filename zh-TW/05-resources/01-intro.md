# 玩家（Players）資源

我們根據資源的名稱來組織應用程式架構。這個應用程式中，只有一個資源（`Players`），所以只有一個 `Players` 資料夾。

`Players` 資料夾將會有跟主階層相同的模組，Elm 架構的一個元件一個模組：

- Players/Messages.elm
- Players/Models.elm
- Players/Update.elm

然而，也會有玩家不同的視界：列表及編輯視界。每個視界都會有自己的 Elm 模組：

- Players/List.elm
- Players/Edit.elm
