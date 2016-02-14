# Showing Errors 2

In the previous article we created a `ShowError` action that populates `errorMessage` in the main model and shows a message in the main view.

This is the approach we will take:

- Players Update will receive a model that includes an address where to send a message when an error occurs.
- On error we will send a message to this address.
- The message will go a mailbox that will be an input for our application.
- The main update will then receive the action and set the error message in the main model.


---

## An alternative approach