# Commands and tasks

In Elm, __tasks__ allow us to make asynchronous operations. A task might succeed or fail and can be chained. They are similar to promises in JavaScript.

A task has the signature: `Task error success`. The first argument is the error type and the second the success type. For example:

- `Task Http.Error String` is a task that fails with a Http.Error or succeeds with a String
- `Task Never Result` is a task that never fails, always succeeds with a `Result`.

Task are usually returned from functions that want to do async operations, e.g. sending an Http request.

## Commands

It 

---

You tell Elm to run a task by using `Task.perform`:

```elm
type Msg
  = OnTaskFail Http.Error
  | onTaskSuccess String

Task.perform OnTaskFail onTaskSuccess task
```

See <http://package.elm-lang.org/packages/elm-lang/core/4.0.0/Task>

`Task.perform` returns a `Cmd` (command), so we need to feed this command to `Html.App` in order to run the task.

Let's build a quick example app:





