# Fonctions : la suite

## Les variables de type

Considérez une fonction avec la signature suivante :

```elm
indexOf : String -> Array String -> Int
```

Cette fonction hypothétique prend une chaîne de caractères et un tableau de chaînes de caractères en paramètre et retourne l'index où la chaîne de caractère donnée à été trouvée dans le tableau, ou -1 si la chaîne n'a pas été trouvée.

Mais que se passe-t-il si à la place, nous avions un tableau d'entiers ? Nous ne pourrions pas utiliser cette fonction. En revanche, nous pouvons rendre cette fonction __générique__ en utilisant des __variables de types__ aussi appelées __stand-ins__ à la place des types spécifiques des variables.

```elm
indexOf : a -> Array a -> Int
```

En remplaçant `String` par `a`, la signature indique maintenant que `indexOf` prend une valeur de n'importe quel type `a` et un tableau du même type `a` et retourne un entier. À partir du moment où les types correspondent, le compilateur sera heureux. Vous pouvez appeler `indexOf` avec un `String` et un tableau de `String`, ou un `Int` et un tableau de `Int`, ça marchera dans les deux cas.

De cette façon, les fonctions peuvent être rendues plus génériques. Il est aussi possible d'avoir plusieurs __variables de type__ :

```elm
switch : ( a, b ) -> ( b, a )
switch ( x, y ) =
  ( y, x )
```

Cette fonction prend en paramètre un tuple de type `a`, `b` et retourne un tuple de type `b`, `a`. Tous ces appels sont valides :

```elm
switch (1, 2)
switch ("A", 2)
switch (1, ["B"])
```

## Fonctions en tant que paramètres

Considérons la signature suivante :

```elm
map : (Int -> String) -> List Int -> List String
```

Cette fonction :

- prend en argument une fonction : la partie `(Int -> String)`
- une liste d'entiers
- et retourne une liste de chaînes de caractères.

La partie intéressante est celle concernant le `(Int -> String)`. Cela signifie qu'une fonction respectant la signature `(Int -> String)` doit être fournie.

Par exemple, la fonction `toString` fournie par Elm est une bonne candidate. Vous pourriez alors appeler la fonction `map` de cette manière :

```elm
map toString [1, 2, 3]
```

Mais `Int` et `String` sont trop spécifiques. C'est pourquoi, la plupart du temps, vous verrez des signatures utilisant des variables de types à la place :

```elm
map : (a -> b) -> List a -> List b
```

Cette fonction transforme une liste de `a` en liste de `b`. Nous nous fichons de ce que `a` et `b` représentent, à partir du moment où la fonction passée comme premier argument utilise ces mêmes types.

Imaginons que nous ayons des fonctions avec ces signatures :

```elm
convertStringToInt : String -> Int
convertIntToString : Int -> String
convertBoolToInt : Bool -> Int
```

Nous pourrions alors appeler notre map générique de cette manière :

```elm
map convertStringToInt ["Hello", "1"]
map convertIntToString [1, 2]
map convertBoolToInt [True, False]
```
