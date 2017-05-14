module Main exposing (..)

import App.Types exposing (..)
import App.Rest exposing (..)
import App.State exposing (..)
import App.View exposing (..)
import NativeUi exposing (program)


main : Program Never Model Msg
main =
    program
        { init = ( model, getScheduleCmd )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
