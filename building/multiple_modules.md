# Multiple modules

Our application is going to grow fast, so keeping things in one file will become hard to maintain quite fast. 

#### Circular dependencies

Another issue we are likely to hit at some point will be circular dependencies in Elm. For example we might have:

- A `Main` module which has a `Player` model on it.
- A `PlayerView` module that renders a player, this want to use the `Player` model declared in `Main`.
- `Main` calls `PlayerView` to render the player.

We now have a circular dependency:

```
Main --> PlayerView
PlayerView --> Main
```

