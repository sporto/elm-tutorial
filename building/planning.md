# Planning

We will build an application that tracks an imaginary roll playing game, this game will have __playes__ and __perks__ that can be associated with each player. 

This application will demonstrate:

- Multiple views
- Nested components
- Breaking the application into resources
- Routing
- Shared state accross the application
- State specific to a component
- Editing
- Validations
- Ajax requests

## Resources



## Wireframes:

The application will have three views:

![Wireframe](plan-v01.png)

### Screen 1

Will show a list of players, from here you can add, delete or edit a player.

This demonstrates:

- Views and sub views
- Routing
- CRUD operations
- Resource organisation

### Screen 2

Shows the edit view for a player. In this screen you can:

- Change the name
- Change the level
- Add or remove perks

This screen demonstrates:

- Editing a resource
- Adding / removing associations between resources

### Screen 3

Show a list of all available perk. In this screen you can search for a perk, see how many players have this perk and expand the details of a perk.

This screen demonstrates:

- Search using the router
- Filtering
- Keeping component specific state (Expand / Collapse buttons)