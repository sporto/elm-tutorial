# Programmation tacite ('point-free style')

La programmation tacite est une manière d'écrire, aussi appelée 'point-free style', en omettant un ou plusieurs argument(s) dans le corps de la fonction. Voyons un exemple.

Voilà une fonction qui ajoute 10 à un nombre :

```elm
add10 : Int -> Int
add10 x =
    10 + x
```

On peut la réécrire en utilisant `+` en notation préfixée (dite 'notation polonaise') :

```elm
add10 : Int -> Int
add10 x =
    (+) 10 x
```

Dans ce cas, l'argument `x` n'est pas strictement nécessaire, et la fonction pourrait être réécrite comme ceci :

```elm
add10 : Int -> Int
add10 =
    (+) 10
```

On voit que le `x` manque à la fois dans l'argument d'entrée de `add10` et dans l'argument passé à `+`. `add10` reste toujours une fonction qui attend un entier pour calculer un résultat. Cette manière d'écrire est appelée programmation tacite ou __point-free style__.

## Plus d'exemples

```elm
select : Int -> List Int -> List Int 
select num list =
    List.filter (\x -> x < num) list

select 4 [1, 2, 3, 4, 5] == [1, 2, 3]
```

est équivalent à :

```elm
select : Int -> List Int -> List Int 
select num =
    List.filter (\x -> x < num)

select 4 [1, 2, 3, 4, 5] == [1, 2, 3]
```

---

```elm
process : List Int -> List Int 
process list =
    reverse list |> drop 3
```

est équivalent à :

```elm
process : List Int -> List Int 
process =
    reverse >> drop 3
```

