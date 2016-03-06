
# Effects

We learned about __StartApp simple__ in the previous chapter. But there is a more featured version which is just called __StartApp__. 

When building Elm application you are likely to use __StartApp__ as the base. __StartApp__ relies on `Effects` heavily, so we need to learn about `Effects`.

We can do a lot of things with just `Task`. For example send Http request or change the browser location. `Effects` are a higher level abstraction than tasks for anything that produces side effects.

`Effects` can be several things:

- A `Task`
- A `Tick` which is used for animations
- `None` which means no effect
- A collection of `Effects`

When working with __StartApp__ your components will return `Effects` rather than tasks. This effects will then be run by __StartApp__ and the Elm runtime.

## Examples

## Tasks to effects

Most of the time we will be creating __tasks__ and converting them to effects:

```elm
aTask |> Effect.task
```

This takes a task and converts it to an effect. See more about this [here](http://package.elm-lang.org/packages/evancz/elm-effects/2.0.1/Effects#task).

## Collection of effects

Other times we will return a collection of effects to run, be we don't return a list of effects, we return just one `Effects`:

```elm
Effect.batch [effect1, effect2]
```

`effect1` and `effect2` are of type `Effects`. `Effect.batch` take a list of `Effects` and converts them into one `Effects`. A group of effects is just another effect.