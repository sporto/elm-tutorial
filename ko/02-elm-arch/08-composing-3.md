> This page covers Elm 0.18

# 조합하기

여기 아키텍쳐를 보여주는 두 다이어그램이 있습니다:

### 초기 렌더링

![Flow](06-composing.png)

(1) __program__ 은 __Main.initialModel__ 을 호출해 초기 모델을 가져온다

(2) __Main__ 은 __Widget.initialModel__ 을 호출한다

(3) __Widget__ 은 자체적인 초기 모델을 리턴한다

(4) __Main__ 은 위젯 모델을 포함하는 메인 모델을 리턴한다

(5) __program__ 은 __Main.view__ 을 호출하여 __main model__ 을 전달한다

(6) __Main.view__ 는 메인 모델의 __widgetModel__ 를 __Widget.view__ 에 전달하여 호출한다

(7) __Widget.view__ 는 __Main__ 에 렌더링될 Html 을 리턴한다

(8) __Main.view__ 는 __program__ 에 렌더링될 Html 을 리턴한다

(9) __program__ 은 이를 브라우저에 렌더링한다

---

### User interaction

![Flow](06-composing_001.png)

(1) 사용자가 증가 (increase) 버튼을 누른다

(2) __Widget.view__ 는 __Main.view__ 를 통해 전달할 __Increase__ 메시지를 발생시킨다

(3) __Main.view__ 는 이 메시지를 태그하여 (WidgetMsg Increase) 로 만들고 __program__ 으로 보낸다

(4) __program__ 은 이 메시지와 메인 모델을 전달하여 __Main.update__ 을 호출한다

(5) 메시지가 __WidgetMsg__ 로 태그 되어 있으므로, __Main.update__ 는 __Widget.update__ 로 메시지와 __widgetModel__ 를 전달하여 처리하게 한다

(6) __Widget.update__ 는 전달된 메시지에 따라 모델에 변경을 가하게 되고 (이 경우는 __Increase__), 갱신된 __widgetModel__ 과 커맨드를 리턴한다

(7) __Main.update__ 는 메인 모델을 업데이트하고 __program__ 로 리턴한다

(8) __program__ 는 갱신된 메인 모델을 뷰에 전달하여 그리도록 한다

## 키 포인트

- Elm 아키텍쳐는 컴포넌트를 몇 단계로 조합 (혹은 중첩) 하더라도 깔끔한 구조를 제공한다
- 자식 컴포넌트는 부모에 대해 알 필요가 없다. 각 타입과 메시지는 컴포넌트 자체적으로 가지고 있기 때문.
- 자식 컴포넌트에 변경사항이 생기면 함수 시그내쳐로 드러나게 된다. 부모 컴포넌트에서 맞춰 주면 된다.
- 부모 컴포넌트는 자식의 모델이나 메시지의 내용에 대해 알 필요가 없다. 자식 컴포넌트에서 필요한 것만 충족하면 된다.
