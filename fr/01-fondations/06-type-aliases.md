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

La définition d'un enregistrement en Elm ressemble à ça :

```elm
{ id : Int
, name : String
}
```

Lorsque vous voudrez écrire une fonction qui prendra en paramètre un enregistrement, sa signature ressemblera à ça :

```elm
label: { id : Int, name : String } -> String
```

Plutôt verbeux, mais heureusement, les alias de type sont là pour nous aider :

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
label: Player -> String
```

Ici nous créeons un alias de type `Player` qui pointe vers la définition d'un enregistrement. Ensuite nous utilisons cet alias de type dans la signature de notre fonction.

## Constructeurs

Les alias de type peuvent être utilisés comme __constructeurs__ de fonctions. C'est à dire que l'on peut créer un véritable enregistrement en utilisant l'alias de type comme fonction.

```elm
type alias Player =
    { id : Int
    , name : String
    }
  
Player 1 "Sam"
==> { id = 1, name = "Sam" }
```

Ici nous créons un alias de type `Player`. Ensuite nous appelons `Player` comme une fonction en lui passant deux paramètres. Elle nous retourne un enregistrement avec les bons attributs. Notez que l'ordre des arguments détermine quelles valeurs vont être assignées à quels attributs.
