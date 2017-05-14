module App.Types exposing (..)

import Date exposing (..)
import RemoteData exposing (..)


type alias Speaker =
    { name : String
    , bio : String
    , twitter : String
    }


type Activity
    = TalkActivity Talk
    | BreakTimeActivity BreakTime


type alias Talk =
    { title : String
    , speaker : String
    , description : String
    , start : Date
    , duration : Int
    }


type alias BreakTime =
    { title : String
    , start : Date
    , duration : Int
    }


type alias Model =
    { activities : WebData (List Activity)
    }


type Msg
    = LoadSchedule
    | ScheduleResponse (WebData (List Activity))
