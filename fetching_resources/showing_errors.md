# Showing Errors

Our application fetches a list of users but it doesn't account for errors. Try sending the request to the incorrect url:

Update __src/Players/Effects.elm__:

```elm
fetchAllUrl : String
fetchAllUrl =
  "http://localhost:4000/playerx"
```

When you refresh you will see an empty list and no indication of the error that just happened.