module Home.Helpers exposing (..)

import Home.Types as Types exposing (..)
import Home.Style as Style exposing (..)
import List.Extra as List
import Maybe.Extra exposing ((?))


getPhotoUrlByIndex : Int -> List Photo -> String
getPhotoUrlByIndex index photos =
    List.getAt index photos ? { url = "" } |> .url


getPhotoSourceUrl : ThumbnailSize -> String -> String -> String
getPhotoSourceUrl size urlPrefix photoUrl =
    case size of
        Types.Large ->
            urlPrefix ++ "large/" ++ photoUrl

        _ ->
            urlPrefix ++ photoUrl


sizeToString : ThumbnailSize -> String
sizeToString size =
    case size of
        Types.Medium ->
            "medium"

        Types.Large ->
            "large"


sizeToClass : ThumbnailSize -> HomeClasses
sizeToClass size =
    case size of
        Types.Medium ->
            Style.Medium

        Types.Large ->
            Style.Large
