module App.Rest exposing (..)

import Http exposing (..)
import Date exposing (Date)
import Json.Decode exposing (Decoder, list, string, at, andThen, int, oneOf, succeed, fail)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)
import App.Types exposing (..)
import RemoteData exposing (..)


date : Decoder Date
date =
    let
        convert : String -> Decoder Date
        convert raw =
            case Date.fromString raw of
                Ok date ->
                    Json.Decode.succeed date

                Err error ->
                    fail error
    in
        string |> Json.Decode.andThen convert


decodeActivity : Decoder Activity
decodeActivity =
    oneOf
        [ decodeTalk |> Json.Decode.andThen (\x -> decode (TalkActivity x))
        , decodeBreakTime |> Json.Decode.andThen (\x -> decode (BreakTimeActivity x))
        ]


decodeTalk : Decoder Talk
decodeTalk =
    decode Talk
        |> required "title" string
        |> required "speaker" string
        |> required "description" string
        |> required "starts" date
        |> required "duration" int


decodeBreakTime : Decoder BreakTime
decodeBreakTime =
    decode BreakTime
        |> required "title" string
        |> required "starts" date
        |> required "duration" int


getScheduleCmd : Cmd Msg
getScheduleCmd =
    list decodeActivity
        |> Http.get "https://elmeurope-api-utmdwkvyqq.now.sh/schedule"
        |> RemoteData.sendRequest
        |> Cmd.map ScheduleResponse
