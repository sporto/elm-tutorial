> This page covers Elm 0.18

# メインメッセージ

ブラウザ閲覧ロケーションが変更されたとき、新しいメッセージがトリガーされます。

__src/Messages.elm__を以下のように変更してください:

```elm
module Messages exposing (..)

import Navigation exposing (Location)
import Players.Messages


type Msg
    = PlayersMsg Players.Messages.Msg
    | OnLocationChange Location
```

- `Navigation`をインポートする
- `OnLocationChange Location`メッセージを追加する
