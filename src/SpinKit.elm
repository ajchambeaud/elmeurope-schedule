module SpinKit exposing (..)

import NativeUi as NativeUi exposing (Property, Node)
import Native.SpinKit
import Json.Encode


type SType
    = CircleFlip
    | Bounce
    | Wave
    | WanderingCubes
    | Pulse
    | ChasingDots
    | ThreeBounce
    | Circle
    | CubeGrid9
    | FadingCircle
    | FadingCircleAlt


spinnerTypeToValue : SType -> String
spinnerTypeToValue sType =
    case sType of
        CircleFlip ->
            "CircleFlip"

        Bounce ->
            "Bounce"

        Wave ->
            "Wave"

        WanderingCubes ->
            "WanderingCubes"

        Pulse ->
            "Pulse"

        ChasingDots ->
            "ChasingDots"

        ThreeBounce ->
            "ThreeBounce"

        Circle ->
            "Circle"

        CubeGrid9 ->
            "9CubeGrid"

        FadingCircle ->
            "FadingCircle"

        FadingCircleAlt ->
            "FadingCircleAlt"


spinner : List (Property msg) -> List (Node msg) -> Node msg
spinner =
    NativeUi.customNode "SpinKit" Native.SpinKit.view


isVisible : Bool -> Property msg
isVisible =
    NativeUi.property "isVisible" << Json.Encode.bool


color : String -> Property msg
color =
    NativeUi.property "color" << Json.Encode.string


size : Int -> Property msg
size =
    NativeUi.property "size" << Json.Encode.int


spinnerType : SType -> Property msg
spinnerType =
    NativeUi.property "type" << (Json.Encode.string << spinnerTypeToValue)
