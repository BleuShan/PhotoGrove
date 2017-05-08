module Home.View exposing (view)

import Home.Types as Types exposing (..)
import Home.Style as Style exposing (..)
import Home.Helpers exposing (..)
import Html exposing (..)
import Html.Attributes as Attr
import Html.Events as Events
import List
import SharedStyle exposing (..)


view : Model -> Html Msg
view model =
    container
        []
        [ columns []
            [ header model ]
        , columns
            []
            [ thumbnails model
            , preview model
            ]
        ]


container : List (Attribute Msg) -> List (Html Msg) -> Html Msg
container attrs =
    div (sharedClass [ Container ] :: attrs)


thumbnails : Model -> Html Msg
thumbnails model =
    column
        []
        [ List.map (thumbnail model) model.photos
            |> columns [ sharedClass [ IsMultiLine ], homeId Thumbnails ]
        ]


columns : List (Attribute Msg) -> List (Html Msg) -> Html Msg
columns attrs =
    div (sharedClass [ Columns ] :: attrs)


sizedColumn : Int -> List (Attribute Msg) -> List (Html Msg) -> Html Msg
sizedColumn columnSize attrs =
    div (sharedClass [ Column, numberToSizeClass columnSize ] :: attrs)


column : List (Attribute Msg) -> List (Html Msg) -> Html Msg
column attrs =
    div (sharedClass [ Column ] :: attrs)


header : Model -> Html Msg
header model =
    sizedColumn 12
        []
        [ h1 [] [ text model.flags.name ] ]


thumbnail : Model -> Photo -> Html Msg
thumbnail model photo =
    column []
        [ img
            [ homeClassList
                [ ( Selected, photo.url == model.selectedPhotoUrl )
                , ( sizeToClass model.selectedThumbnailSize, True )
                ]
            , Attr.src (getPhotoSourceUrl model.selectedThumbnailSize model.flags.urlPrefix photo.url)
            , Events.onClick (SelectPhotoByUrl photo.url)
            ]
            []
        ]


preview : Model -> Html Msg
preview model =
    column
        []
        [ img
            [ homeClass [ Style.Large ]
            , Attr.src (getPhotoSourceUrl Types.Large model.flags.urlPrefix model.selectedPhotoUrl)
            ]
            []
        ]
