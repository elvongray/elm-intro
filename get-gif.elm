module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

import Http 
import Json.Decode as Decode

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
    { topic: String
    , gifUrl: String
    , error: String
    }


init: (Model, Cmd Msg)
init = 
    (Model "cats" "waiting.gif" "", Cmd.none)


-- Update 


type Msg 
    = MorePlease
    | NewGif (Result Http.Error String)
    | NewTopic String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MorePlease ->
            (model, getRandomGif model.topic)  

        NewTopic topic ->
            ( { model | topic = topic }, Cmd.none)
        
        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none)

        NewGif (Err _) ->
            ( { model | error = "Could not load the gif" }, Cmd.none)


-- View 


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [text model.topic]
        , img [src model.gifUrl] []
        , input [ type_ "text", onInput NewTopic] []
        , button [ onClick MorePlease ] [ text "More Please" ]
        , showError model.error
        ]    


-- View functions

showError : String -> Html Msg
showError error =
    div [][
        if String.isEmpty error then text "" else text error
    ]
    


--- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url = 
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
        
        request = 
            Http.get url decodeGifUrl
    in
        Http.send NewGif request


decodeGifUrl : Decode.Decoder String
decodeGifUrl = 
    Decode.at ["data", "image_url"] Decode.string
