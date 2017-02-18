# Improvements

Here is a list of possible improvement you can try on this app.

## Create and delete players

I have left this off in order to keep the tutorial short, definitely an important feature.

## Change the name of a player

## Show an error message when an Http request fails

At the moment if fetching or saving players fail we do nothing. It would be nice to show an error message to the user.

## Even better error messages

Even better than just showing error messages it would be great to:

- Show different types of flash messages e.g. error and info
- Show several flash messages at the same time
- Have the ability to dismiss a message
- Remove a message automatically after a few seconds

## Optimistic updates

At the moment all update functions are pessimistic. Meaning that they don't change the models until there is a succesful response from the server. One big improvement to the application would be to add optimistic creation, update and deletion. But this will also mean better error handling.

## Validations

We should avoid having players without name. One nice feature would be to have a validation on the player's name so it cannot be empty.

## Add perks and bonuses

We can add a list of perks that a player can have. These perk would be equipment, apparel, scrolls, accessories, etc. e.g. "Steel sword" would be one. Then we would have associations between players and perks.

Each perk would have a bonus associated with it. Then players will have a calculated strength that is their level plus all the bonuses they have.

---

For a more featured version of this application see the master branch of <https://github.com/sporto/elm-tutorial-app>.
