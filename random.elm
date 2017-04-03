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
        , svgNode (dieFace model.dieFace)
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


dieFace : Int -> List (Svg msg)
dieFace num =
    let
        rectangleCover =
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
            ]

        noCircles =
            case num of
                1 ->
                    [ circle [ SvgA.cx "60", SvgA.cy "60", SvgA.r "20" ] [] ]

                2 ->
                    [ circle [ SvgA.cx "35", SvgA.cy "60", SvgA.r "15" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "60", SvgA.r "15" ] []
                    ]

                3 ->
                    [ circle [ SvgA.cx "60", SvgA.cy "40", SvgA.r "15" ] []
                    , circle [ SvgA.cx "35", SvgA.cy "70", SvgA.r "15" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "70", SvgA.r "15" ] []
                    ]

                4 ->
                    [ circle [ SvgA.cx "35", SvgA.cy "40", SvgA.r "15" ] []
                    , circle [ SvgA.cx "35", SvgA.cy "80", SvgA.r "15" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "40", SvgA.r "15" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "80", SvgA.r "15" ] []
                    ]

                5 ->
                    [ circle [ SvgA.cx "35", SvgA.cy "40", SvgA.r "10" ] []
                    , circle [ SvgA.cx "35", SvgA.cy "80", SvgA.r "10" ] []
                    , circle [ SvgA.cx "60", SvgA.cy "60", SvgA.r "10" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "40", SvgA.r "10" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "80", SvgA.r "10" ] []
                    ]

                6 ->
                    [ circle [ SvgA.cx "35", SvgA.cy "30", SvgA.r "10" ] []
                    , circle [ SvgA.cx "35", SvgA.cy "60", SvgA.r "10" ] []
                    , circle [ SvgA.cx "35", SvgA.cy "90", SvgA.r "10" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "30", SvgA.r "10" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "60", SvgA.r "10" ] []
                    , circle [ SvgA.cx "85", SvgA.cy "90", SvgA.r "10" ] []
                    ]

                _ ->
                    []
    in
        List.append rectangleCover noCircles
