# Effects

We learnt about __StartApp simple__ in the previous chapter. But there is a more featured version which is just called __StartApp__. 

When building Elm application you are likely to use __StartApp__ as the base. __StartApp__

Effects are a higher level abstraction than tasks for anything that produces side effects. An __Effects__ type is always a collection of effects to run (as opposed to a task which is singular). Our components will return __effects__, these effects will be run by the Elm runtime.

Most of the time we will be creating __tasks__ and converting them to effects.

