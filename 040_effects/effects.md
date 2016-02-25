
# Effects

We learnt about __StartApp simple__ in the previous chapter. But there is a more featured version which is just called __StartApp__. 

When building Elm application you are likely to use __StartApp__ as the base. __StartApp__ relies on `Effects` heavily, so we need to learn about `Effects`.

We can do a lot of things with just `Task`. For example send Http request or change the browser location. `Effects` are a higher level abstraction than tasks for anything that produces side effects.

`Effects` can be several things:

- A `Task`
- A `Tick` which is used for animations
- `None` which means no effect
- A collection of `Effects`

When working with __StartApp__ your components will return `Effects` rather than tasks. This effects will then be run by __StartApp__ and the Elm runtime.

## Examples

Most of the time we will be creating __tasks__ and converting them to effects:

```elm
  aTask |> Effect.task
```

