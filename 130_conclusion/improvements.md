# Improvements

## DRY

There is a good amount of repeated code in update branches. Specially in error handling. This code could be abstracted but I haven't done that for clarity sake.

## Optimistic updates

At the moment all update functions are pesimistic. Meaning that they don't change the models until there is a succesful response from the server. One big improvement to the application would be to add optimistic creation, update and deletion. But this will also mean better error handling.

## Other libraries

Some parts of the application code is a bit clumsy because I have stuck to Elm core libraries most of the time (with the exception of the router). 

For example using `on` for change events on an input field or using `Http.send`. For example <http://package.elm-lang.org/packages/lukewestby/elm-http-extra/latest> would make doing Http requests simpler.

# Possible features

## Better flash messages

Currently we only handle error messages and we can only show one. Some improvements would be:

- Show different types of flash messages e.g. error and info
- Show several flash messages
- Have the ability to dismiss a message
- Remove a message automatically after a few seconds

## Validations

We should avoid having players without name. One nice feature would be to have a validation on the player's name so it cannot be empty.

## Add perks and bonuses

We can add a list of perks that a player can have. These perk would be equipment, apparel, scrolls, accessories, etc. e.g. "Steel sword" would be one. The we would have associations between players and perks.

Each perk would have a bonus associated with it. Then players will have a calculated strength that is their level plus all the bonuses they have.

---

For a more featured version of this application see the master branch of <https://github.com/sporto/elm-tutorial-app>.
