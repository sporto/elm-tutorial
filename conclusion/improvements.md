# Improvements

## DRY

There is a good amount of repeated code in update branches. Specially in error handling. This code could be abstracted but I haven't done that for clarity sake.

## Optimistic updates

At the moment all update functions are pesimistic. Meaning that they don't change the models until there is a succesful response from the server. One big improvement to the application would be to add optimistic creation, update and deletion. But this will also mean better error handling.



# Possible features