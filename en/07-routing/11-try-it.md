> This page covers Tutorial v2. Elm 0.18.

## Test it

Go to the list `http://localhost:3000/#players`. You should now see an Edit button, upon clicking it the location should change to the edit view.

Up to this point your application code should look <https://github.com/sporto/elm-tutorial-app/tree/018-v02-07-navigation>.

## Navigation approaches

We are using hash routing here which is simple. But it is a bit ugly because your URLs will need to include a `#`. Hash routing will also conflict if you want to use the `#` for its original intent, which is creating anchors on a page.

As an alternative you can use "path" routing, which uses push state. Instead of having something like `app.com/#users` you will have `app.com/users`, which is nicer.

You can use path routing in Elm using the `Navigation` module too. See [this repository for an explanation and example](https://github.com/sporto/elm-navigation-pushstate).
