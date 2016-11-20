# Playersリソース

アプリケーション構造を、アプリケーションのリソース名で整理します。 このアプリでは、1つのリソース(`Players`)しか持たないので、`Players`ディレクトリしか存在しません。

`Players`ディレクトリには、メインレベルのモジュールと同じように、Elmアーキテクチャのコンポーネントごとに1つのモジュールがあります。

- Players/Messages.elm
- Players/Models.elm
- Players/Update.elm

しかし、我々はプレイヤーのための異なるビューを持つことになります。リストビューと編集ビューです。 各ビューには独自のElmモジュールがあります。

- Players/List.elm
- Players/Edit.elm
