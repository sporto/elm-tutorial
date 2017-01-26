# 감싸기

일반적으로 `update` 나 `view` 함수는 이렇게 생겼습니다:

```elm
view : Model -> Html Msg
view model =
  ...
```

혹은

```elm
update : Msg -> Model -> (Model, Cmd Msg)
update message model =
  ...
```

이 컴포넌트에 속하는 `Model` 만을 인자로 사용해야 한다는 생각에 갇히기 쉽습니다. 가끔은 부가적인 정보가 필요할 때도 있고 이는 물론 가능합니다. 예를 들면:

```elm
type alias Context =
  { model : Model
  , time : Time
  }

view : Context -> Html Msg
view context =
  ...
```

이 함수는 컴포넌트의 모델에 추가적으로 부모의 모델로부터 `time` 을 받습니다.
