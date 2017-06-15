module SharedStyle
    exposing
        ( SharedStyleClasses(..)
        , SharedStyleIds(..)
        , css
        , primaryColor
        , numberToSizeClass
        , sharedId
        , sharedClass
        , sharedClassList
        , white
        )

import Css exposing (..)
import Css.Elements exposing (..)
import Css.Namespace exposing (namespace)
import Html exposing (Attribute)
import Html.CssHelpers exposing (Namespace, withNamespace)
import Home.Types exposing (Msg)
import List


type SharedStyleClasses
    = Columns
    | Column
    | Container
    | Is1
    | Is2
    | Is3
    | Is4
    | Is5
    | Is6
    | Is7
    | Is8
    | Is9
    | Is10
    | Is11
    | Is12
    | IsGrid
    | IsMultiLine
    | IsGapless
    | Level
    | LevelRight
    | LevelLeft
    | LevelItem


type SharedStyleIds
    = Root


primaryColor : Color
primaryColor =
    hex "#60b5cc"


white : Color
white =
    hex "#FFFFFF"


sizeClasses : List SharedStyleClasses
sizeClasses =
    [ Is1
    , Is2
    , Is3
    , Is4
    , Is5
    , Is6
    , Is7
    , Is8
    , Is9
    , Is10
    , Is11
    , Is12
    ]


sizeClassToNumber : SharedStyleClasses -> number
sizeClassToNumber class =
    case class of
        Is1 ->
            1

        Is2 ->
            2

        Is3 ->
            3

        Is4 ->
            4

        Is5 ->
            5

        Is6 ->
            6

        Is7 ->
            7

        Is8 ->
            8

        Is9 ->
            9

        Is10 ->
            10

        Is11 ->
            11

        Is12 ->
            12

        _ ->
            0


numberToSizeClass : number -> SharedStyleClasses
numberToSizeClass number =
    case number of
        1 ->
            Is1

        2 ->
            Is2

        3 ->
            Is3

        4 ->
            Is4

        5 ->
            Is5

        6 ->
            Is6

        7 ->
            Is9

        8 ->
            Is8

        9 ->
            Is9

        10 ->
            Is10

        11 ->
            Is11

        12 ->
            Is12

        _ ->
            if number < 1 then
                Is1
            else
                Is12


sharedNamespace : Namespace String SharedStyleClasses SharedStyleIds Msg
sharedNamespace =
    withNamespace "PhotoGrove__"


sharedId : SharedStyleIds -> Attribute Msg
sharedId =
    sharedNamespace.id


sharedClass : List SharedStyleClasses -> Attribute Msg
sharedClass =
    sharedNamespace.class


sharedClassList : List ( SharedStyleClasses, Bool ) -> Attribute Msg
sharedClassList =
    sharedNamespace.classList


screenMinWidthMediaQuery : number -> List Snippet -> Snippet
screenMinWidthMediaQuery width =
    mediaQuery ("screen and (min-width:" ++ (toString width) ++ "px)")


screenMaxWidthMediaQuery : number -> List Snippet -> Snippet
screenMaxWidthMediaQuery width =
    mediaQuery ("screen and (max-width:" ++ (toString width) ++ "px)")


mobile : List Snippet -> Snippet
mobile =
    screenMaxWidthMediaQuery (tabletPxWidth - 1)


tabletPxWidth : number
tabletPxWidth =
    769


tablet : List Snippet -> Snippet
tablet =
    screenMinWidthMediaQuery tabletPxWidth


desktopPxWidth : number
desktopPxWidth =
    960


desktop : List Snippet -> Snippet
desktop =
    screenMinWidthMediaQuery (desktopPxWidth + 40)


widescreenPxWidth : number
widescreenPxWidth =
    1152


widescreen : List Snippet -> Snippet
widescreen =
    screenMinWidthMediaQuery (widescreenPxWidth + 40)


fullhdPxWidth : number
fullhdPxWidth =
    1344


fullhd : List Snippet -> Snippet
fullhd =
    screenMinWidthMediaQuery (fullhdPxWidth + 40)


pulledLevel : Mixin
pulledLevel =
    mixin
        [ alignItems center
        , flexBasis auto
        , flexGrow zero
        , flexShrink zero
        , descendants
            [ class LevelItem
                [ pseudoClass "not(:last-child)"
                    [ marginRight (Css.rem 0.75) ]
                ]
            ]
        ]


css : Stylesheet
css =
    (stylesheet << namespace sharedNamespace.name)
        [ html
            [ boxSizing borderBox
            ]
        , everything
            [ boxSizing inherit
            , before [ boxSizing inherit ]
            , after [ boxSizing inherit ]
            ]
        , body
            [ backgroundColor (hex "#4c4c4c")
            , color white
            ]
        , img
            [ border3 (px 1) solid white
            ]
        , h1
            [ fontFamilies [ "Verdana", "Helvetica", .value sansSerif ]
            , color primaryColor
            ]
        , id Root
            [ displayFlex
            , flexDirection column
            , minHeight (vh 100)
            ]
        , main_
            [ flex (num 1) ]
        , class Column <|
            [ display block
            , flex2 (num 1) zero
            , padding (Css.rem (3 / 4))
            ]
                ++ List.map
                    (\sizeClass ->
                        withClass sizeClass
                            [ flex none
                            , width (pct ((sizeClassToNumber sizeClass) / 12 * 100))
                            ]
                    )
                    sizeClasses
        , class Columns
            [ displayFlex
            , marginTop (Css.rem -(3 / 4))
            , marginLeft (Css.rem -(3 / 4))
            , marginRight (Css.rem -(3 / 4))
            , lastChild [ marginBottom (Css.rem -(3 / 4)) ]
            , pseudoClass "not(:last-child)"
                [ marginBottom (Css.rem (3 / 4)) ]
            , withClass IsMultiLine
                [ flexWrap wrap
                ]
            , withClass IsGapless
                [ marginTop zero
                , marginLeft zero
                , marginRight zero
                , lastChild [ marginBottom zero ]
                , pseudoClass "not(:last-child)"
                    [ marginBottom (Css.rem (3 / 2)) ]
                , children
                    [ class Column
                        [ padding zero
                        , margin zero
                        ]
                    ]
                ]
            ]
        , class Container
            [ position relative
            ]
        , class Level
            [ marginBottom (Css.rem 1.5)
            , alignItems center
            , justifyContent spaceBetween
            , descendants
                [ img
                    [ display inlineBlock
                    , verticalAlign top
                    ]
                ]
            ]
        , class LevelItem
            [ alignItems baseline
            , displayFlex
            , flexBasis auto
            , flexGrow zero
            , flexShrink zero
            , justifyContent center
            , descendants
                [ selector """[type="radio"]:not(:last-child)"""
                    [ marginRight (Css.rem 0.25) ]
                ]
            ]
        , class LevelLeft
            [ pulledLevel
            , justifyContent flexStart
            ]
        , class LevelRight
            [ pulledLevel
            , justifyContent flexEnd
            ]
        , button
            [ textTransform uppercase
            , fontSize (px 13)
            , backgroundColor (hex "#60b5cc")
            , border zero
            , borderRadius (px 2)
            , padding2 zero (Css.rem 2)
            , height (px 36)
            , lineHeight (px 36)
            , outline zero
            , zIndex (int 1)
            , cursor pointer
            , property "transition" "all 300ms ease-out"
            , property "box-shadow"
                "0 2px 2px 0 rgba(0,0,0,0.14), 0 1px 5px 0 rgba(0,0,0,0.12), 0 3px 1px -2px rgba(0,0,0,0.2)"
            , hover
                [ property "box-shadow"
                    "0 3px 3px 0 rgba(0,0,0,0.14), 0 1px 7px 0 rgba(0,0,0,0.12), 0 3px 1px -1px rgba(0,0,0,0.2)"
                , color (hex "#f9f9f9")
                ]
            , active
                [ backgroundColor (hex "#4c4c4c")
                , property "transition" "all 25ms ease"
                , property "box-shadow"
                    "0 2px 2px 0 rgba(0,0,0,0.14), 0 1px 5px 0 rgba(0,0,0,0.12), 0 3px 1px -2px rgba(0,0,0,0.2)"
                ]
            ]
        , mobile
            [ class LevelItem
                [ pseudoClass "not(:last-child)"
                    [ marginBottom (Css.rem 0.75) ]
                ]
            , class LevelLeft
                [ adjacentSiblings
                    [ class LevelRight
                        [ marginTop (Css.rem 1.5) ]
                    ]
                ]
            ]
        , tablet
            [ class Columns
                [ withClass IsGrid
                    [ flexWrap wrap
                    , children
                        [ class Column
                            [ maxWidth (pct (1 / 3 * 100))
                            , padding (Css.rem (3 / 4))
                            , width (pct (1 / 3 * 100))
                            , adjacentSiblings
                                [ class Column [ marginLeft zero ] ]
                            ]
                        ]
                    ]
                ]
            , class Level
                [ displayFlex
                , children
                    [ class LevelItem
                        [ flexGrow (num 1) ]
                    ]
                ]
            , class LevelRight
                [ displayFlex ]
            , class LevelLeft
                [ displayFlex ]
            ]
        , desktop
            [ class Container
                [ margin2 zero auto
                , minWidth (px desktopPxWidth)
                , width (px desktopPxWidth)
                ]
            ]
        , widescreen
            [ class Container
                [ minWidth (px widescreenPxWidth)
                , width (px widescreenPxWidth)
                ]
            ]
        , fullhd
            [ class Container
                [ minWidth (px fullhdPxWidth)
                , width (px fullhdPxWidth)
                ]
            ]
        ]
