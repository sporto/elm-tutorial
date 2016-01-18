# StartApp with effects

As discussed __StartApp.Simple__ doesn't allow for having side effects. This side effects might be:

- Changing the browser route
- Sending an Ajax request

These are definitely necessary things to do when building a web application. We will use the full version of StartApp from now on.

## Effects

__StartApp__ (not simple) introduces the concepts of __effects__. Instead of returning just the new state in our __update__ function we will now return a tuple with the __new state__ and __effects__ to run. It looks like: `(model, effects)`.

Let's convert the application we looked at in the last chapter to __StartApp__.
