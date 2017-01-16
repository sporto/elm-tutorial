# Imports and modules

In Elm you import a module by using the `import` keyword e.g.

```elm
import Html
```

This imports the `Html` module. Then you can use functions and types from this module by using its fully qualified path:

```elm
Html.div [] []
```

You can also import a module and expose specific functions and types from it:

```elm
import Html exposing (div)
```

`div` is mixed in the current scope. So you can use it directly:

```elm
div [] []
```

You can even expose everything in a module:

```elm
import Html exposing (..)
```

Then you would be able to use every function and type in that module directly. But this is not recommended most of the time because we end up with ambiguity and possible clashes between modules.

## Modules and types with the same name

Many modules export types with the same name as the module. For example, the `Html` module has an `Html` type and the `Task` module has a `Task` type.

So this function that returns an `Html` element:

```elm
import Html

myFunction : Html.Html
myFunction =
    ...
```

Is equivalent to:

```elm
import Html exposing (Html)

myFunction : Html
myFunction =
    ...
```

In the first one we only import the `Html` module and use the fully qualified path `Html.Html`.

In the second one we expose the `Html` type from the `Html` module. And use the `Html` type directly.

## Module declarations

When you create a module in Elm, you add the `module` declaration at the top:

```elm
module Main exposing (..)
```

`Main` is the name of the module. `exposing (..)` means that you want to expose all functions and types in this module. Elm expects to find this module in a file called __Main.elm__, i.e. a file with the same name as the module.

You can have deeper file structures in an application. For example, the file __Players/Utils.elm__ should have the declaration:

```elm
module Players.Utils exposing (..)
```

You will be able to import this module from anywhere in your application by:

```elm
import Players.Utils
```




