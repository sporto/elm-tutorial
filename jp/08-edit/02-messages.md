# メッセージ

まず、必要なメッセージを追加してみましょう。

__src/Players/Messages.elm__に以下を追加：

```elm
type Msg
    ...
    | ChangeLevel PlayerId Int
    | OnSave (Result Http.Error Player)
```

- ユーザーがレベルを変更したいときに `ChangeLevel`がトリガーされます。第2のパラメータは、レベルをどれだけ変化させるかを示す整数です。減少する場合は-1、増加する場合は1になります。
- その後、プレーヤーをAPIに更新するようリクエストします。 `OnSave`はAPIからの成功した応答の後にトリガされます。
- `OnSave`は成功時には更新されたプレイヤーを運び、失敗時にはHttpエラーを運びます。
