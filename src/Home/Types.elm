module Home.Types exposing (..)

import Http


type Msg
    = None
    | SelectPhotoByUrl String
    | SelectPhotoByIndex Int
    | SelectThumbnailSize ThumbnailSize
    | SurpriseMe
    | LoadPhotos (Result Http.Error (List Photo))


type ThumbnailSize
    = Small
    | Medium
    | Large


type alias Flags =
    { name : String
    , version : String
    , urlPrefix : Maybe String
    }


type alias Model =
    { photos : List Photo
    , selectedPhotoUrl : Maybe String
    , loaded : Bool
    , loadingError : Maybe String
    , selectedThumbnailSize : ThumbnailSize
    , flags :
        { name : String
        , version : String
        , urlPrefix : String
        }
    }


type alias Photo =
    { url : String
    , size : Int
    , title : String
    }
