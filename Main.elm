module App exposing (..)


import Html exposing (..)

import Messages exposing (Msg(..))
import Models exposing (..)
import Update exposing (..)
import View exposing (..)



main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : (Model, Cmd Msg)
init = 
    (Model [] "" "", Cmd.none)
