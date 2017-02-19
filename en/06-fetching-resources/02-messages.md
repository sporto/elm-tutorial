> This page covers Tutorial v2. Elm 0.18.

# Messages

First let's create the messages we need for fetching players. Add a new import and message to __src/Msgs.elm__

```elm
module Msgs exposing (..)

import Models exposing (Player)
import RemoteData exposing (WebData)


type Msg
    = OnFetchPlayers (WebData (List Player))
```

`OnFetchPlayers` will be called when we get the response from the server. This message will carry a `WebData (List Player)`.

`WebData` is a type that provides four constructors: `NotAsked`, `Loading`, `Success` and `Failure`. These four possible constructors describe all states in which an HTTP resource could be. Read more about this [here](http://blog.jenkster.com/2016/06/how-elm-slays-a-ui-antipattern.html).