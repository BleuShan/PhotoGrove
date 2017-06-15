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
    = Small
    | Medium
    | Large
    | Selected


type HomeIds
    = Thumbnails
    | Preview


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
        [ id Preview
            [ descendants
                [ img
                    [ width (px 500)
                    , property "box-shadow"
                        "0 2px 2px 0 rgba(0,0,0,0.14), 0 1px 5px 0 rgba(0,0,0,0.12), 0 3px 1px -2px rgba(0,0,0,0.2)"
                    , hover
                        [ property "box-shadow"
                            "0 3px 3px 0 rgba(0,0,0,0.14), 0 1px 7px 0 rgba(0,0,0,0.12), 0 3px 1px -1px rgba(0,0,0,0.2)"
                        , zIndex (int 1)
                        ]
                    ]
                ]
            ]
        , id Thumbnails
            [ descendants
                [ img
                    [ cursor pointer
                    , property "transition" "all 300ms ease"
                    , property "box-shadow"
                        "0 2px 2px 0 rgba(0,0,0,0.14), 0 1px 5px 0 rgba(0,0,0,0.12), 0 3px 1px -2px rgba(0,0,0,0.2)"
                    , withClass Selected
                        [ cursor default
                        , property "box-shadow"
                            "0 3px 3px 0 rgba(0,0,0,0.14), 0 1px 7px 0 rgba(0,0,0,0.12), 0 3px 1px -1px rgba(0,0,0,0.2)"
                        , border3 (px 3) solid primaryColor
                        , zIndex (int 1)
                        ]
                    , withClass Small
                        [ width (px 50)
                        ]
                    , withClass Medium
                        [ width (px 100)
                        ]
                    , withClass Large
                        [ width (px 200)
                        ]
                    , pseudoClass "hover:not(.PhotoGrove-Home__Selected)"
                        [ property "box-shadow"
                            "0 3px 3px 0 rgba(0,0,0,0.14), 0 1px 7px 0 rgba(0,0,0,0.12), 0 3px 1px -1px rgba(0,0,0,0.2)"
                        , border3 (px 1) solid primaryColor
                        , zIndex (int 1)
                        ]
                    ]
                ]
            ]
        ]
