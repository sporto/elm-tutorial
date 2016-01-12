# StartApp

In this chapter we have added:

- A __Model__ for keeping the state of our application
- An __update__ function to centralise changes
- __actions__ so we can handle different user actions
- A __mailbox__ so we have a central place where to send messages to

This pattern for organising an Elm application is referred as the __Elm architecture__. This pattern is so useful that there is an elm package called __StartApp__ built just for this. __StartApp__ abstracts the common parts of the pattern:

- Creating a mailbox
- Mapping our signals through `foldp`

Let's convert our application to use start app