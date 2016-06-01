# Try it

Let's try what we have so far. Run the application by doing:

```
npm run dev
```

in one terminal, and:

```
npm run api
```

in another terminal.

Then go to `http://localhost:3000` in your browser. You should see the list of users.

![screenshot](07-list.png)

If you go to `http://localhost:3000/#players/2` then you should see one user.

![screenshot](07-edit.png)

Next we will add some navigation.

--- 

There are several others routing matching libraries you can use instead of UrlParser, check [Hop](https://github.com/sporto/hop) for example.
