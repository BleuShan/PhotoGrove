module Home.View exposing (view)

import Home.Helpers exposing (..)
import Home.Style as Style exposing (..)
import Home.Types as Types exposing (..)
import Html exposing (..)
import Html.Attributes as Attributes
import Html.Events as Events exposing (onClick)
import List
import Maybe.Extra exposing (isJust, isNothing, unwrap)
import Rocket exposing ((=>))
import SharedStyle exposing (..)
import View.Extra exposing (viewIf, viewJust, viewMaybe)


view : Model -> Html Msg
view model =
    container
        [ sharedId Root ]
        [ header model
        , viewMaybe errorContent (content model) model.loadingError
        ]


container : List (Attribute Msg) -> List (Html Msg) -> Html Msg
container attrs =
    div (sharedClass [ Container ] :: attrs)


columns : List (Attribute Msg) -> List (Html Msg) -> Html Msg
columns attrs =
    div (sharedClass [ Columns ] :: attrs)


sizedColumn : Int -> List (Attribute Msg) -> List (Html Msg) -> Html Msg
sizedColumn columnSize attrs =
    div (sharedClass [ Column, numberToSizeClass columnSize ] :: attrs)


column : List (Attribute Msg) -> List (Html Msg) -> Html Msg
column attrs =
    div (sharedClass [ Column ] :: attrs)


sizeChooser : ( Model, ThumbnailSize ) -> Html Msg
sizeChooser ( model, thumbnailSize ) =
    label [ sharedClass [ LevelItem ] ]
        [ input
            [ Attributes.type_ "radio"
            , Attributes.name "size"
            , Attributes.checked (model.selectedThumbnailSize == thumbnailSize)
            , Events.onClick (SelectThumbnailSize thumbnailSize)
            ]
            []
        , span [] [ text <| sizeToString thumbnailSize ]
        ]


header : Model -> Html Msg
header model =
    let
        showControls =
            model.loaded && (isNothing model.loadingError)
    in
        Html.header [ sharedClass [ Columns, IsMultiLine ] ]
            [ sizedColumn 12
                []
                [ h1 [] [ text model.flags.name ] ]
            , (flip viewIf showControls) <|
                sizedColumn 12
                    []
                    [ div [ sharedClass [ Level ] ]
                        [ div [ sharedClass [ LevelLeft ] ] <|
                            List.append
                                [ div [ sharedClass [ LevelItem ] ]
                                    [ h3 [] [ text "Thumbnail size: " ] ]
                                ]
                                (List.map sizeChooser
                                    [ model => Types.Small
                                    , model => Types.Medium
                                    , model => Types.Large
                                    ]
                                )
                        , div [ sharedClass [ LevelRight ] ]
                            [ button
                                [ sharedClass [ LevelItem ]
                                , onClick SurpriseMe
                                ]
                                [ text "Surprise me" ]
                            ]
                        ]
                    ]
            ]


content : Model -> Html Msg
content model =
    main_
        [ sharedClass [ Columns ] ]
        [ thumbnails model
        , viewJust (preview model.flags.urlPrefix model.photos) model.selectedPhotoUrl
        ]


errorContent : String -> Html Msg
errorContent message =
    main_
        [ sharedClass [ Level ] ]
        [ div [ sharedClass [ LevelItem ] ] [ text message ]
        ]


thumbnails : Model -> Html Msg
thumbnails { selectedThumbnailSize, selectedPhotoUrl, photos, flags } =
    let
        urlPrefix =
            flags.urlPrefix
    in
        column
            []
            [ List.map (thumbnail selectedThumbnailSize urlPrefix selectedPhotoUrl) photos
                |> columns [ sharedClass [ IsMultiLine ], homeId Thumbnails ]
            ]


thumbnail : ThumbnailSize -> String -> Maybe String -> Photo -> Html Msg
thumbnail thumbnailSize urlPrefix selectedPhotoUrl { url, title, size } =
    column []
        [ img
            [ homeClassList
                [ ( Selected, unwrap False ((==) url) selectedPhotoUrl )
                , ( sizeToClass thumbnailSize, True )
                ]
            , Attributes.src <| getPhotoSourceUrl Types.Medium urlPrefix url
            , Attributes.title <| title ++ " [" ++ (toString size) ++ " KB]"
            , Events.onClick (SelectPhotoByUrl url)
            ]
            []
        ]


preview : String -> List Photo -> String -> Html Msg
preview urlPrefix photos url =
    column
        [ homeId Preview ]
        [ img
            [ Attributes.src <| getPhotoSourceUrl Types.Large urlPrefix url
            , Attributes.title (unwrap "" .title (getPhotoByUrl url photos))
            ]
            []
        ]
