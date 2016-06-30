# Alias de type

Un __alias de type__ en Elm est, comme son nom l'indique, un alias désignant quelque chose d'autre. Par exemple en Elm, il existe les types de base `Int` et `String`. Il est possible de leur créer des alias :

```elm
type alias PlayerId = Int

type alias PlayerName = String
```

Ici nous avons créé deux alias de type qui pointent simplement vers des types de base d'Elm. Cela nous permet, lorsque nous avons une fonction comme ceci :

```elm
label: Int -> String
```

De l'écrire comme cela :

```elm
label: PlayerId -> PlayerName
```

De cette manière, il est beaucoup plus simple de comprendre ce qu'attend la fonction.

## Enregistrements (records)

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
