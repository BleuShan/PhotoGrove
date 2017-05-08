module Home.State exposing (..)

import Home.Types exposing (..)
import Home.Helpers exposing (..)
import Maybe.Extra exposing ((?))
import Rocket exposing ((=>))


init : Flags -> ( Model, List (Cmd Msg) )
init flags =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedPhotoUrl = "1.jpeg"
    , selectedThumbnailSize = Medium
    , flags =
        { flags
            | urlPrefix = (flags.urlPrefix ? "http://elm-in-action.com/")
        }
    }
        => []


update : Msg -> Model -> ( Model, List (Cmd Msg) )
update msg model =
    case msg of
        SelectPhotoByUrl url ->
            { model | selectedPhotoUrl = url } => []

        SelectPhotoByIndex index ->
            { model | selectedPhotoUrl = getPhotoUrlByIndex index model.photos } => []

        None ->
            model => []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
