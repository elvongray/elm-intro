module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick) 

import Regex exposing (contains, regex)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , age: String
    , submit: Bool
    }


model : Model
model =
    Model "" "" "" "" False



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name name ->
            { model | name = name }

        Password password ->
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age age ->
            { model | age = age }

        Submit ->
            { model | submit = True }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ input [ type_ "text", placeholder "Name", onInput Name ] []
        , input [ type_ "text", placeholder "Age", onInput Age][]
        , input [ type_ "password", placeholder "Password", onInput Password ] []
        , input [ type_ "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
        , input [ type_ "submit", onClick Submit ]
        [
            text "Submit"
        ]
        , viewValidation model
        ]


viewValidation : Model -> Html Msg
viewValidation model =
    let
        ( color, message ) =
            if model.password /= model.passwordAgain then
                ( "red", "Passwords do not match" )
            else if ( String.length model.password ) < 8 then
                ( "red", "minimum password length is 8" )
            else if contains ( regex "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$" ) 
                model.password /= True then
                ( "red", "Password must contain upper case, lower case, and numeric characters" )
            else if isInteger model.age /= True then
                ( "red", "Age must be an integer" )
            else
                ( "green", "OK" )
    in
        div [ style [ ( "color", color ), hideDiv model ] ] [ text message ]

isInteger: String -> Bool
isInteger value =
    case String.toInt value of
        Ok int -> True
        Err str -> False

hideDiv : Model -> (String, String)
hideDiv model =
    if model.submit == True then
        ("", "")
    else 
        ("display", "none")

