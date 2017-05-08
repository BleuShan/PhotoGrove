module Main exposing (..)

import Html
import Rocket
import Home.Types exposing (Model, Msg, Flags)
import Home.State exposing (update, init, subscriptions)
import Home.View exposing (view)


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = init >> Rocket.batchInit
        , update = update >> Rocket.batchUpdate
        , view = view
        , subscriptions = subscriptions
        }
