# Type aliases

A __type alias__ in Elm is, as its name says, an alias for something else. For example, in Elm you have the core `Int` and `String` types. You can create aliases for them:

```elm
type alias PlayerId = Int

type alias PlayerName = String
```

Here we have created a couple of type alias that simply point to other core types. This is useful because instead of having a function like:

```elm
label: Int -> String
```

You can write it like:

```elm
label: PlayerId -> PlayerName
```

In this way, it is much clearer what the function is asking for.

## Records

A record definition in Elm looks like:

```elm
{ id : Int
, name : String
}
```

If you were to have a function that takes a record, you would have to write a signature like:

```elm
label: { id : Int, name : String } -> String
```

Quite verbose, but type aliases help a lot with this:

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
label: Player -> String
```

Here we create a `Player` type alias that points to a record definition. Then we use that type alias in our function signature.

## Constructors

Type aliases can be used as __constructor__ functions. Meaning that we can create a real record by using the type alias as a function.

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
Player 1 "Sam"
==> { id = 1, name = "Sam" }
```

Here we create a `Player` type alias. Then, we call `Player` as a function with two parameters. This gives us back a record with the proper attributes. Note that the order of the arguments determines which values will be assigned to which attributes.
