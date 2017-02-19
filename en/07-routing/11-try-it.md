> This page covers Tutorial v2. Elm 0.18.

## Test it

Go to the list `http://localhost:3000/#players`. You should now see an Edit button, upon clicking it the location should change to the edit view.

Up to this point your application code should look <https://github.com/sporto/elm-tutorial-app/tree/018-07-navigation>.

## Navigation approaches

We are using hash routing here which is simple. But it is a bit ugly because your URLs will need to include a `#`. Hash routing will also conflict if you want to use the `#` for its original intent, which is creating anchors on a page.

As an alternative you can use "path" routing, which uses push state. Instead of having something like `app.com/#users` you will have `app.com/users`, which is nicer.

You can use path routing in Elm using the `Navigation` module too. To do this you will need:

- Create a message for changing the location e.g. `ChangeLocation String`.
- Use `Navigation.newUrl` to create a command to change the location.
- In your links you will need to trigger this message with the new location.
- If you still want to display the target link using `href`, you will need to prevent the browser default behaviour using `onWithOptions` from `Html.Events`.
