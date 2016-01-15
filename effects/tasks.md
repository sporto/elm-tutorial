# Tasks

In Elm, __tasks__ allow us to make asynchronous operations. A task might success or fail. They are similar to promises in JavaScript.


Let's start with an application that displays a message every second:

```elm
import Html
import Time

clockSignal : Signal Time.Time
clockSignal =
  Time.every Time.second

messageSignal : Signal String
messageSignal = 
  Signal.map toString clockSignal

view : String -> Html.Html
view message =
  Html.text message

main: Signal.Signal Html.Html
main =
  Signal.map view messageSignal
```

In you run this in your browser you will see a number that changes slightly every second. This number is the current time (as a unix timestamp).

Let's go through the example:

- `clockSignal` gives a signal that changes every second, the output of this signal is the current timestamp.
- `messageSignal` just converts `clockSignal` to a string.
- `view` takes a string and return html
- `main` maps the `messageSignal` through `view` in order to produce a signal of html, which is what we see.


## Adding a task

Now, instead of displaying the current timestamp every second, we want to display a message coming through ajax. To do this we will need a fake server, so we can send a request to it and get a message back.

## Adding a fake server


We will use node for our fake server, because if you are reading this is quite likely that you already have node installed and are familiar with it.

In another terminal go to the same folder with your Elm code and start a node project with all the defaults:

```bash
npm init
```

Then install `json-server`:

```bash
npm install json-server -S
```

Create an `index.js` file in that directory with:

```js
var jsonServer = require('json-server')

// Returns an Express server
var server = jsonServer.create()

server.get('/status', function (req, res) { 
	res.send(Math.random().toString()) 
})

console.log('Listening at 3000')
server.listen(3000)
```

Run `json-server`:

```bash
node index.js
```

Open `http://localhost:3000/` in your browser, you should see the json-server welcome page.

Exit json-server by doing `Ctrl-C`.

The first time we ran json-server it generated a `db.json` file. Open this file in a text editor and add:






First let's install the __Http__ module, stop Elm reactor, then:

```elm
elm package install evancz/elm-http
elm reactor
```

TODO


You can read more about tasks [in the official site](http://elm-lang.org/guide/reactivity).