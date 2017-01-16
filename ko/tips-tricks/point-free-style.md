# Point free style

Point free is a style of writing a function where you omit one or more arguments in the body. To understand this let's see an example.

Here we have a function that adds 10 to a number:

```elm
add10 : Int -> Int
add10 x =
    10 + x
```

We can rewrite this using the `+` using a prefix notation:

```elm
add10 : Int -> Int
add10 x =
    (+) 10 x
```

The argument `x` in this case is not strictly necessary, we could rewrite this as:

```elm
add10 : Int -> Int
add10 =
    (+) 10
```

Note how `x` is missing as both an input argument to `add10` and argument to `+`. `add10` is still a function that requires an integer to calculate a result. Omitting arguments like this is called __point free style__.

## Some more examples

```elm
select : Int -> List Int -> List Int 
select num list =
    List.filter (\x -> x < num) list

select 4 [1, 2, 3, 4, 5] == [1, 2, 3]
```

is the same as:

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

is the same as:

```elm
process : List Int -> List Int 
process =
    reverse >> drop 3
```

