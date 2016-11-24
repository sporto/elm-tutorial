>このページでは、Elm 0.18

# Playersメッセージ

まず、プレイヤーを取得するために必要なメッセージを作成しましょう。__src/Players/Messages.elm__に新しいインポートとメッセージを追加します。

```elm
module Players.Messages exposing (..)

import Http
import Players.Models exposing (PlayerId, Player)


type Msg
    = OnFetchAll (Result Http.Error (List Player))
```

`OnFetchAll`はサーバからの応答を取得するときに呼び出されます。このメッセージは`Http.Error`かフェッチされたプレイヤーのリストのいずれかになる` Result`を保持します。
