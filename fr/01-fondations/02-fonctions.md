# Fonctions : les bases

Ce chapitre couvre la syntaxe de base d'Elm avec laquelle il est important de se familiariser : fonctions, signatures de fonctions, application partielle et opérateur _pipe_.

## Fonctions

Elm supporte deux types de fonctions :

- les fonctions anonymes
- les fonctions nommées

### Fonctions anonymes

Une fonction anonyme, comme son nom l'indique, est une fonction créée sans nom :

```elm
\x -> x + 1

\x y -> x + y
```

On place les arguments entre la barre oblique inversée et la flèche, et on dit quoi faire de ces arguments à droite de la flèche.


### Fonctions nommées

Une fonction nommée en Elm ressemble à cela :

```elm
add1 : Int -> Int
add1 x =
    x + 1
```

- La première ligne de cet exemple est la signature de la fonction. Cette signature est optionnelle, mais il est recommandé de la fournir : cela permet d'exprimer directement l'intention de la fonction.
- Le reste est le corps de la fonction. L'implémentation doit se conformer à la signature définie plus haut.

Dans le cas de cette fonction, la signature dit ceci : si l'on passe en argument à cette fonction un entier (Int), elle retourne un entier.

Cette fonction s'appelle de la manière suivante :

```elm
add1 3
```


En Elm, on utilise des *espaces* pour exprimer l'application d'une fonction (plutôt que des parenthèses, par exemple).

Voilà une autre fonction nommée :

```elm
add : Int -> Int -> Int
add x y =
    x + y
```


Cette fonction prend deux arguments (deux Int) et retourne un Int. Elle s'appelle comme ceci :

```elm
add 2 3
```

### Pas d'argument

En Elm, une fonction qui ne prend pas d'argument est une constante :

```elm
name =
  "Sam"
```


### Comment sont appliquées les fonctions

Comme expliqué ci-dessus, une fonction qui prend deux arguments ressemble à cela :

```elm
divide : Float -> Float -> Float
divide x y =
    x / y
```

On peut interpréter cette signature comme signifiant que la fonction prend deux Float (nombre à virgule flottante) et retourne un Float.

```elm
divide 5 2 == 2.5
```

Ce n'est pourtant pas tout à fait exact. En effet, en Elm, toutes les fonctions prennent exactement un argument et retournent un résultat, qui peut être une autre fonction. Voyons le cas de la fonction ci-dessus :

 ```elm
-- Quand on fait :

divide 5 2

-- C'est comme si on faisait :

((divide 5) 2)

-- D'abord, `divide 5` est évalué.
-- L'argument `5` est appliqué à `divide`, ce qui produit une fonction intermédiaire.

divide 5 -- -> fonction intermédiaire

-- Appelons cette fonction intermédiaire `divide5`.
-- Si on pouvait voir la signature et le corps de cette fonction, ça donnerait quelque chose comme ça :

divide5 : Float -> Float
divide5 y =
  5 / y

-- On dispose d'une fonction à laquelle le `5` a déjà été appliqué.

-- Puis, le second argument est appliqué, ici `2`

divide5 2

-- Ce qui retourne le résultat final
```

Si on écrit habituellement ça sans les parenthèses, c'est parce que l'application de fonction est **associative à gauche**.


### Grouper avec les parenthèses

Lorsque vous voulez appeler une fonction avec le résulat de l'appel d'une autre fonction, vous devez utiliser des parenthèses pour grouper les appels :

```elm
add 1 (divide 12 3)
```

Ici, le résultat de `divide 12 3` est passé en second paramètre de la fonction `add`.

En comparaison, beaucoup d'autres langages écriraient la même chose de cette façon :

```js
add(1, divide(12, 3))
```

## Application partielle de fonction

Comme expliqué plus haut, toute fonction accepte un unique argument et retourne une autre fonction ou un résultat.
Cela signifie qu'il est possible d'appeler une fonction, comme la fonction `add` ci-dessus, en ne lui donnant qu'un argument, par exemple `add 2`, et d'obtenir en retour une **fonction partiellement appliquée**.
Cette fonction résultante a pour signature `Int -> Int`.

`add 2` retourne une autre fonction avec la valeur `2` liée au premier argument. Appeler cette nouvelle fonction avec une seconde valeur retournera `2 + ` la seconde valeur :

```elm
add2 = add 2
add2 3 -- result 5
```

L'application partielle de fonction est incroyablement utile en Elm pour rendre le code plus lisible et pour permettre le passage d'états entre les différentes fonctions de votre application.

## L'opérateur _pipe_

Comme nous l'avons vu plus haut, vous pouvez imbriquer des fonctions de cette manière :

```elm
add 1 (multiply 2 3)
```

Cet exemple est relativement trivial, mais considérons un exemple plus complexe :

```elm
sum (filter (isOver 100) (map getCost records))
```

Ce code est difficile à lire, car il se résoud de l'intérieur vers l'extérieur. L'opérateur _pipe_  nous permet d'écrire ce genre d'expression de manière plus lisible :

```elm
3
    |> multiply 2
    |> add 1
```

Ceci est possible grâce à l'application partielle de fonctions. Dans cet exemple, la valeur `3` est passée à une fonction partiellement appliquée `multiply 2`. Son résultat est à son tour passé à une fonction partiellement appliquée `add 1`.

En utilisant l'opérateur _pipe_, l'exemple complexe ci-dessus s'écrirait de cette façon :

```elm
records
    |> map getCost
    |> filter (isOver 100)
    |> sum
```
