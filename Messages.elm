module Messages exposing (..)


import Models exposing (..)


type Msg
    = AddPhoneNumber PhoneNumber
    | InputNumber String
    | InputName String