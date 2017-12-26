module Update exposing (..)


import Models exposing (..)
import Messages exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        AddPhoneNumber phoneNumber -> 
            let
                user = User model.inputName
                phoneNumber = PhoneNumber model.inputNumber user
            in
                ( { model | phoneNumbers = phoneNumber :: model.phoneNumbers }, Cmd.none )

        InputName name -> 
            ( { model | inputName = name }, Cmd.none )

        InputNumber number -> 
            ( { model | inputNumber = number }, Cmd.none )
