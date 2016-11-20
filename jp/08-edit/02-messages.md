# メッセージ

まず、必要なメッセージを追加してみましょう。

__src/Players/Messages.elm__に以下を追加：

```elm
type Msg
    ...
    | ChangeLevel PlayerId Int
    | SaveSuccess Player
    | SaveFail Http.Error
```

- ユーザーがレベルを変更したいときに `ChangeLevel`がトリガーされます。第2のパラメータは、レベルをどれだけ変化させるかを示す整数です。減少する場合は-1、増加する場合は1になります。
- その後、プレーヤーをAPIに更新するようリクエストします。 `SaveSuccess`はAPIからの成功した応答の後にトリガされ、失敗の場合は`SaveFail`がトリガされます。
