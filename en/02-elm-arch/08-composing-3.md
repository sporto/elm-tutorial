# Composing

Here are two diagrams that illustrate this architecture:

### Intial render

![Flow](06-composing.png)

(1) __App__ calls __Main.initialModel__ to get the intial model for the application

(2) __Main__ calls __Widget.initialModel__

(3) __Widget__ returns its initial model

(4) __Main__ returns a composed main model which includes the widget model

(5) __App__ calls __Main.view__, passing the __main model__

(6) __Main.view__ calls __Widget.view__, passing the __widgetModel__ from the main model

(7) __Widget.view__ returns the rendered Html to __Main__

(8) __Main.view__ returns the rendered Html to __App__

(9) __App__ renders this to the browser.

---

### User interaction

![Flow](06-composing_001.png)

(1) User clicks on the increase button

(2) __Widget.view__ emits an __Increase__ message which is picked up by __Main.view__.

(3) __Main.view__ tags this message so it becomes (WidgetMsg Increase) and it is send along to __App__ 

(4) __App__ calls __Main.update__ with this message and the main model

(5) As the message was tagged with __WidgetMsg__, __Main.update__ delegates the update to __Widget.update__, sending along the way the __widgetModel__ part of the main model

(6) __Widget.update__ modifies the model according to the given message, in this case __Increase__. And returns the modified __widgetModel__ plus a command

(7) __Main.update__ updates the main model and returns it to __App__

(8) __App__ then renders the view again passing the update main model

## Key points

- The Elm architecture offers a clean way to compose (or nest) components at as many levels as you need.
- Children components do not need to know anything about the parent. They define their own types and messages.
- If a child component needs something in particular (e.g. an additional model) it "asks" for it by using the function signatures. The parent is responsible for providing what the children need.
- A parent doesn't need to know what is in its children models or what their messages are.  It only needs to provide what its children asks.
