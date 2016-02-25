# Imports and Modules

In Elm you import a module by using the `import` keyword e.g.

```
import Html
```

This imports the `Html` module from core. Then you can use functions and types from this module by using it fully qualified path:

```
Html.div [] []
```

You can also import modules and expose functions and types on it:

```
import Html exposing (div)
```

`div` is mixed in the current scope. So you can use it directly:

```
div [] []
```

You can even expose everything in a module:

```
import Html exposing (..)
```

Then you would be able to use every function and type in that module directly. But this is not recommended most of the time because we end up with ambiguity and possible clashes between modules.

## Types and modules with the same name

Many modules export types with the same name as the module. For example the `Html` module has a `Html` type and the `Signal` module has a `Signal` type.

