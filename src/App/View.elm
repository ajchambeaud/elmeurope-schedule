module App.View exposing (..)

import NativeUi as Ui exposing (Node)
import NativeUi.Style as Style exposing (defaultTransform)
import NativeUi.Elements as Elements exposing (..)
import NativeUi.Image as Image exposing (..)
import NativeUi.Properties exposing (horizontal, pagingEnabled)
import NativeApi.Dimensions exposing (window)
import App.Types exposing (..)
import RemoteData exposing (..)


breakTimeView : BreakTime -> Node Msg
breakTimeView item =
    Elements.view
        [ Ui.style
            [ Style.alignItems "center"
            , Style.justifyContent "space-around"
            , Style.backgroundColor "green"
            , Style.width window.width
            ]
        ]
        [ text
            [ Ui.style
                [ Style.textAlign "center"
                , Style.marginBottom 30
                , Style.fontSize 24
                ]
            ]
            [ Ui.string (item.title)
            ]
        ]


talkView : Talk -> Node Msg
talkView talk =
    Elements.view
        [ Ui.style
            [ Style.alignItems "center"
            , Style.justifyContent "space-around"
            , Style.backgroundColor "yellow"
            , Style.width window.width
            ]
        ]
        [ text [] [ Ui.string ("Talk: " ++ talk.title) ]
        , text [] [ Ui.string ("Speaker: " ++ talk.speaker) ]
        ]


activityView : Activity -> Node Msg
activityView activity =
    case activity of
        TalkActivity talk ->
            talkView talk

        BreakTimeActivity bt ->
            breakTimeView bt


header : Node Msg
header =
    let
        imageSource =
            { uri = "https://seeklogo.com/images/E/elm-logo-9DEF2A830B-seeklogo.com.png"
            , cache = Just ForceCache
            }
    in
        Elements.view
            [ Ui.style
                [ Style.alignItems "flex-start"
                , Style.backgroundColor "black"
                , Style.flexDirection "row"
                , Style.alignItems "flex-start"
                , Style.justifyContent "space-between"
                , Style.marginTop 30
                , Style.padding 5
                , Style.alignSelf "stretch"
                ]
            ]
            [ image
                [ Ui.style
                    [ Style.height 64
                    , Style.width 64
                    ]
                , source imageSource
                ]
                []
            , Elements.view
                [ Ui.style
                    [ Style.alignItems "center"
                    , Style.justifyContent "space-around"
                    , Style.alignSelf "stretch"
                    ]
                ]
                [ text
                    [ Ui.style
                        [ Style.textAlign "center"
                        , Style.color "#63b4c9"
                        , Style.fontSize 24
                        ]
                    ]
                    [ Ui.string "Elm Europe Schedule"
                    ]
                ]
            ]


footer : Node Msg
footer =
    Elements.view
        [ Ui.style
            [ Style.backgroundColor "black"
            , Style.flexDirection "column"
            , Style.justifyContent "center"
            , Style.height 45
            ]
        ]
        [ text
            [ Ui.style
                [ Style.textAlign "center"
                , Style.color "#63b4c9"
                ]
            ]
            [ Ui.string "Made with 🌳 and ❤ by @ajchambeaud"
            ]
        ]


loadingView : Node Msg
loadingView =
    Elements.view
        [ Ui.style
            [ Style.alignItems "center"
            , Style.backgroundColor "yellow"
            , Style.width window.width
            ]
        ]
        [ text [] [ Ui.string "Loading" ]
        ]


errorView : String -> Node Msg
errorView err =
    Elements.view
        [ Ui.style
            [ Style.alignItems "center"
            , Style.backgroundColor "red"
            , Style.width window.width
            ]
        ]
        [ text [] [ Ui.string <| "Error: " ++ err ]
        ]


view : Model -> Node Msg
view model =
    let
        mainView =
            case model.activities of
                Loading ->
                    loadingView

                Failure err ->
                    errorView (toString err)

                Success activities ->
                    Elements.scrollView [ horizontal True, pagingEnabled True ] <|
                        List.map
                            (\activity -> activityView activity)
                            activities

                _ ->
                    loadingView
    in
        Elements.view
            [ Ui.style
                [ Style.alignItems "stretch"
                , Style.flexDirection "column"
                , Style.justifyContent "space-between"
                , Style.backgroundColor "white"
                , Style.flex 1
                ]
            ]
            [ header
            , mainView
            , footer
            ]
