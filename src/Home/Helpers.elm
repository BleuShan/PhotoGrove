module Home.Helpers exposing (..)

import Home.Style as Style exposing (..)
import Home.Types as Types exposing (..)
import Json.Decode exposing (Decoder, int, string)
import Json.Decode.Pipeline exposing (decode, optional, required)
import List.Extra as List


getPhotoByUrl : String -> List Photo -> Maybe Photo
getPhotoByUrl url photos =
    List.find ((==) url << .url) photos


getPhotoUrlByIndex : Int -> List Photo -> Maybe String
getPhotoUrlByIndex index photos =
    Maybe.map .url (List.getAt index photos)


getPhotoSourceUrl : ThumbnailSize -> String -> String -> String
getPhotoSourceUrl thumbnailSize urlPrefix photoUrl =
    case thumbnailSize of
        Types.Large ->
            urlPrefix ++ "large/" ++ photoUrl

        _ ->
            urlPrefix ++ photoUrl


photoDecoder : Decoder Photo
photoDecoder =
    decode Photo
        |> required "url" string
        |> required "size" int
        |> optional "title" string "(untitled)"


sizeToString : ThumbnailSize -> String
sizeToString size =
    case size of
        Types.Small ->
            "small"

        Types.Medium ->
            "medium"

        Types.Large ->
            "large"


sizeToClass : ThumbnailSize -> HomeClasses
sizeToClass size =
    case size of
        Types.Small ->
            Style.Small

        Types.Medium ->
            Style.Medium

        Types.Large ->
            Style.Large
