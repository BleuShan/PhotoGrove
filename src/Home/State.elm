module Home.State exposing (..)

import Home.Helpers exposing (..)
import Home.Types exposing (..)
import Http exposing (Error)
import Json.Decode exposing (list, string)
import List exposing (isEmpty)
import Maybe.Extra exposing ((?))
import Random
import Rocket exposing ((=>))


init : Flags -> ( Model, List (Cmd Msg) )
init flags =
    let
        appendSlash url =
            if String.endsWith "/" url then
                url
            else
                url ++ "/"

        urlPrefix =
            Maybe.map appendSlash flags.urlPrefix

        initialModel =
            { photos =
                []
            , selectedPhotoUrl = Nothing
            , loaded = False
            , loadingError = Nothing
            , selectedThumbnailSize = Medium
            , flags =
                { flags
                    | urlPrefix = (urlPrefix ? "http://elm-in-action.com/")
                }
            }
    in
        initialModel => [ loadPhotos initialModel ]


loadPhotos : Model -> Cmd Msg
loadPhotos model =
    let
        url =
            model.flags.urlPrefix ++ "photos/list.json"
    in
        list photoDecoder
            |> Http.get url
            |> Http.send LoadPhotos


update : Msg -> Model -> ( Model, List (Cmd Msg) )
update msg model =
    case msg of
        SelectPhotoByUrl url ->
            { model | selectedPhotoUrl = Just url } => []

        SelectPhotoByIndex index ->
            { model | selectedPhotoUrl = getPhotoUrlByIndex index model.photos } => []

        SelectThumbnailSize thumbnailSize ->
            { model | selectedThumbnailSize = thumbnailSize } => []

        SurpriseMe ->
            let
                randomPhotoPicker =
                    Random.int 0 ((List.length model.photos) - 1)
            in
                model => [ Random.generate SelectPhotoByIndex randomPhotoPicker ]

        LoadPhotos (Ok photos) ->
            { model
                | photos = photos
                , loaded = True
                , loadingError = Nothing
            }
                => []

        LoadPhotos (Err _) ->
            { model
                | loadingError = Just "Error! (Try turning it off and on again?)"
                , loaded = True
            }
                => []

        None ->
            model => []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
