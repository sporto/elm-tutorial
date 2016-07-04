# Fonctions : les bases

Ce chapitre couvre la syntaxe de base d'Elm avec laquelle il est important de se familiariser : fonctions, signatures de fonctions, application partielle et opérateur _pipe_.

## Fonctions

Voici à quoi ressemble une fonction en Elm :

```elm
add : Int -> Int -> Int
add x y =
    x + y
```

La première ligne de cet exemple est la signature de la fonction. Cette signature est optionnelle, mais il est recommandé de la fournir : cela permet de se rendre directement compte de l'intention de la fonction.

Cette fonction nommée `add` prend deux entiers en argument (`Int -> Int`) et retourne un autre entier (le troisième `-> Int`).

La deuxième ligne est la déclaration de la fonction. Les paramètres sont `x` et `y`.

Ensuite nous avons le corps de la fonction `x + y` qui retourne juste la somme des paramètres.

Cette fonction s'appelle de la manière suivante :

```elm
add 1 2
```

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

Avec Elm il est possible d'appeler une fonction, comme la fonction `add` ci-dessus, en ne lui donnant qu'un argument, par exemple `add 2`.

Ceci retourne une autre fonction avec la valeur `2` liée au premier argument. Appeler cette nouvelle fonction avec une seconde valeur retournera `2 + ` la seconde valeur :

```elm
add2 = add 2
add2 3 -- result 5
```

Une autre façon de voir une fonction avec une signature du type `add : Int -> Int -> Int` est de se dire que c'est une fonction qui prend un entier en paramètre et retourne une autre fonction. Cette autre fonction prend un autre entier en paramètre et retourne un entier.

Ce principe est appelé application partielle de fonction. Il est incroyablement utile en Elm pour rendre le code plus lisible et pour permettre le passage d'états entre les différentes fonctions de votre application.

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
