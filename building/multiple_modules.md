# Multiple modules

Our application is going to grow fast, so keeping things in one file will become hard to maintain quite fast. 

### Circular dependencies

Another issue we are likely to hit at some point will be circular dependencies in Elm. For example we might have:

- A `Main` module which has a `Player` model on it.
- A `PlayerView` module that renders a player, this want to use the `Player` model declared in `Main`.
- `Main` calls `PlayerView` to render the player.

We now have a circular dependency:

```
Main --> PlayerView
PlayerView --> Main
```

#### How to break it?

In this case what we need to do is move the `Player` model out of `Main`. In a place where it can be imported by both `Main` and `PlayerView`. We will end up with three modules:

- Main
- PlayerView
- Models (contains Player)

To deal with circular dependencies in Elm the easiest thing to do is to break your application in smaller modules. Try creating smaller modules for things like __actions__, __models__, __effects__ and __utilities__, which are modules that are usually imported by many components.

## Breaking our application

Let's break our application in smaller modules:

__src/Actions.elm__

```
module Actions (..) where

type Action
  = NoOp
```

