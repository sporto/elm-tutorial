# The Players resource

We will organise our application structure by the name of the resources in our application. In this app we only have one resource (`Players`) so there will be only a `Players` directory.

The `Players` directory will have modules for the components of the Elm architecture, just like what we did with the main level:

- Players/Messages.elm
- Players/Models.elm
- Players/Update.elm

However, we will have different views for players: A list and a edit view. So these will be different modules:

- Players/List.elm
- Players/Edit.elm

