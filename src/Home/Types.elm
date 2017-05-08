module Home.Types exposing (..)


type Msg
    = None
    | SelectPhotoByUrl String
    | SelectPhotoByIndex Int


type ThumbnailSize
    = Medium
    | Large


type alias Flags =
    { name : String
    , version : String
    , urlPrefix : Maybe String
    }


type alias Model =
    { photos : List Photo
    , selectedPhotoUrl : String
    , selectedThumbnailSize : ThumbnailSize
    , flags :
        { name : String
        , version : String
        , urlPrefix : String
        }
    }


type alias Photo =
    { url : String }
