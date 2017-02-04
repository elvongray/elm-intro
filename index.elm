module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import Svg exposing (..)
import Svg.Attributes as SvgA
import Random


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- Model


type alias Model =
    { dieFace : Int
    }



-- Update


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newFace ->
            ( Model newFace, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ Html.text (toString model.dieFace) ]
        , svgNode dieRect
        , button [ onClick Roll ] [ Html.text "Roll" ]
        ]



--- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- Init


init : ( Model, Cmd Msg )
init =
    ( Model 1, Cmd.none )


svgNode : List (Svg msg) -> Html msg
svgNode node =
    svg
        [ SvgA.width "120", SvgA.height "120", SvgA.viewBox "0 0 120 120" ]
        node


dieRect : List (Svg msg)
dieRect =
    [ rect
        [ SvgA.x "10"
        , SvgA.y "10"
        , SvgA.width "100"
        , SvgA.height "100"
        , SvgA.rx "15"
        , SvgA.ry "15"
        , SvgA.fill "none"
        , SvgA.stroke "black"
        , SvgA.strokeWidth "2"
        ]
        []
        , circle [ SvgA.cx "60", SvgA.cy "60", SvgA.r "20" ] []
    ]
