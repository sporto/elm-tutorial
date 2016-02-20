# Improvements

## DRY

There is a good amount of repeated code in update branches. Specially in error handling. This code could be abstracted but I haven't done that for clarity sake.

## Optimistic updates

At the moment all update functions are pesimistic. Meaning that they don't change the models until there is a succesful response from the server. One big improvement to the application would be to add optimistic creation, update and deletion. But this will also mean better error handling.

## Other libraries

Some parts of the application code is a bit clumsy because I have stuck to Elm core libraries most of the time (with the exception of the router). 

For example using `on` for change events on an input field or using `Http.send`.

# Possible features

## Better flash messages

Currently we only handle error messages and we can only show one. Some improvements would be:

- Show different types of flash messages e.g. error and info
- Show several flash messages
- Have the ability to dismiss a message
- Remove a message automatically after a few seconds

