port module Stylesheets exposing (..)

import Css.File exposing (..)
import Css.Normalize
import Home.Style as HomeStyle
import SharedStyle
import Rocket exposing ((=>))


port files : CssFileStructure -> Cmd msg


cssFiles : CssFileStructure
cssFiles =
    toFileStructure
        [ "normalize.css" => compile [ Css.Normalize.css ]
        , "common.css" => compile [ SharedStyle.css ]
        , "home.css" => compile [ HomeStyle.css ]
        ]


main : CssCompilerProgram
main =
    compiler files cssFiles
