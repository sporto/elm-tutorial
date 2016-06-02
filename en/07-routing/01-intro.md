# Routing introduction

Let's add a routing to our application. We will be using the [Elm Navigation package](http://package.elm-lang.org/packages/elm-lang/navigation/) and [UrlParser](http://package.elm-lang.org/packages/evancz/url-parser/).

- Navigation provides the means to change the browser location and respond to changes
- UrlParser provides route matchers

First install the packages:

```
elm package install elm-lang/navigation 1.0.0
elm package install evancz/url-parser 1.0.0
```

## Flow

Here are a couple of diagrams to understand how routing will work.

![Flow](01-intro.png)

1. When the page first loads the `Navigation` module will fetch the current URL and send it to a `parse` function that we will provide.
1. This parse function will return a `Route` that matches.
1. Navigation then sends this matched `Route` to our application `init` function.
1. In `init` we create the application model, we store the matched route there.
1. Navigation then sends the initial model to the view to render the application.

![Flow](01-intro_001.png)


