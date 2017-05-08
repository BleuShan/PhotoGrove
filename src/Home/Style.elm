module Home.Style
    exposing
        ( HomeClasses(..)
        , HomeIds(..)
        , css
        , homeId
        , homeClass
        , homeClassList
        )

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Html exposing (Attribute)
import Home.Types exposing (Msg)
import SharedStyle exposing (white, primaryColor)


type HomeClasses
    = Medium
    | Large
    | Selected


type HomeIds
    = Thumbnails


homeNamespace : Namespace String HomeClasses HomeIds Msg
homeNamespace =
    withNamespace "PhotoGrove-Home__"


homeId : HomeIds -> Attribute Msg
homeId =
    homeNamespace.id


homeClass : List HomeClasses -> Attribute Msg
homeClass =
    homeNamespace.class


homeClassList : List ( HomeClasses, Bool ) -> Attribute Msg
homeClassList =
    homeNamespace.classList


css : Stylesheet
css =
    (stylesheet << namespace homeNamespace.name)
        [ class Medium
            [ width (px 200)
            ]
        , class Large
            [ width (px 500)
            ]
        , class Selected
            [ margin zero
            , border3 (px 6) solid primaryColor
            ]
        , id Thumbnails
            [ descendants
                [ img
                    [ cursor pointer
                    , withClass Selected
                        [ cursor default
                        ]
                    ]
                ]
            ]
        ]
