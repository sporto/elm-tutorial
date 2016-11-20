>このページでは、Elm 0.17

# Playersメッセージ

まず、プレイヤーを取得するために必要なメッセージを作成しましょう。__src/Players/Messages.elm__に新しいインポートとメッセージを追加します。

```elm
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = FetchAllDone (List Player)
    | FetchAllFail Http.Error
```

`FetchAllDone`はサーバからの応答を取得するときに呼び出されます。 このメッセージには、取得したプレーヤーのリストが表示されます。

`FetchAllFail`はデータの取得に問題がある場合に呼び出されます。
