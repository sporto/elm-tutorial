# コンテキスト

典型的な `update`や` view`関数は次のようになります：

```elm
view : Model -> Html Msg
view model =
  ...
```

あるいは

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  ...
```

このコンポーネントの`Model`だけを渡すということで非常にシンプルな話です。しかし、余分な情報が必要なとき、viewに追加的な情報を渡すのも問題ありません。例えば：

```elm
type alias Context =
  { model : Model
  , time : Time
  }

view : Context -> Html Msg
view context =
  ...
```

この関数は、親モデルで定義されているコンポーネントモデルと`time`を必要としています。

