module Models exposing (..)


type alias User = 
    { name : String
    }


type alias PhoneNumber = 
    { number : String
    , user : User
    }
    
type alias Model =
    { phoneNumbers : List PhoneNumber
    , inputName : String
    , inputNumber : String
    }
