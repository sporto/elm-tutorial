# Effects

Effects are a higher level abstraction than tasks for anything that produces side effects. An __Effects__ type is always a collection of effects to run (as opposed to a task which is singular). Our components will return __effects__ that need to be ran by the Elm runtime. 

Most of the time we will be creating __tasks__ and converting them to effects.


