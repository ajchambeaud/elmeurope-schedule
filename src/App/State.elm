module App.State exposing (..)

import App.Types exposing (..)
import RemoteData exposing (..)


model : Model
model =
    { activities = NotAsked
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ScheduleResponse data ->
            ( { model | activities = data }
            , Cmd.none
            )

        _ ->
            ( model, Cmd.none )
