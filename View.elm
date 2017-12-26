module View exposing (..)


import Html exposing (Html, ul, li)
import Element exposing (..)
import Element.Attributes exposing (..)
import Style exposing (..)
import Style.Background as Background
import Style.Font as Font
import Style.Color as Color
import Style.Border as Border
import Color exposing (..)
import Element.Input as Input
import Element.Events as Events

import Models exposing (..)
import Messages exposing (Msg(InputNumber, InputName, AddPhoneNumber))


view : Model -> Html Msg
view model =
    Element.layout stylesheet <|
        column Container [ spacing 20 ] 
            [ h1 Title [ center, padding 50 ] (text "Phone Numbers")
            , row Form [ center, paddingLeft 400, paddingRight 400 ]
                [ Input.text 
                    FormInput 
                    [ padding 10 ] 
                    { onChange = InputNumber
                    , value = model.inputNumber
                    , label = 
                        Input.placeholder 
                            { text = "Phone Number..."
                            , label = Input.labelLeft (el FormLabel [ width (px 100), padding 10 ] (text "Number"))
                            }
                    , options =
                        [ Input.errorBelow (el Error [ hidden ] (text "This is an Error!"))
                        ]
                    }
                ]
            , row Form [ center, paddingLeft 400, paddingRight 400 ]
                [ Input.text 
                    FormInput 
                    [ padding 10 ] 
                    { onChange = InputName
                    , value = model.inputName
                    , label = 
                        Input.placeholder 
                            { text = "Name..."
                            , label = Input.labelLeft (el FormLabel [ width (px 100), padding 10 ] (text "Name"))
                            }
                    , options =
                        [ Input.errorBelow (el Error [ hidden ] (text "This is an Error!"))
                        ]
                    }
                ]
            , row Form [ center, paddingLeft 400, paddingRight 400 ]
                [ button Submit [ width (px 100), height (px 50), Events.onClick (saveNumber model) ] (text "ADD")
                ]
            , row None [ center, paddingLeft 400, paddingRight 400 ]
                [ table Table [ width fill ] 
                    [ (el TableHeader [ center, padding 10 ] (text "Numbers")) :: (viewNumbers model)
                    , (el TableHeader [ center, padding 10 ] (text "Names")) :: (viewNames model)
                    ]
                ] 
            ]


sansSerif : List Font
sansSerif =
    [ Font.font "helvetica"
    , Font.font "arial"
    , Font.font "sans-serif"
    ]


viewNames : Model -> List (Element Styles variation msg)
viewNames model = 
    List.map viewName model.phoneNumbers


viewName : PhoneNumber -> Element Styles variation msg
viewName phone = 
    el Tr [ padding 10 ] (text phone.user.name)


viewNumbers : Model -> List (Element Styles variation msg)
viewNumbers model = 
    List.map viewNumber model.phoneNumbers


viewNumber : PhoneNumber -> Element Styles variation msg
viewNumber phone = 
    el Tr [ padding 10 ] (text phone.number)


saveNumber : Model -> Msg 
saveNumber model = 
    AddPhoneNumber <| createPhoneNumber model
        

createPhoneNumber : Model -> PhoneNumber
createPhoneNumber model = 
    { number = model.inputNumber
    , user = createUser model 
    }


createUser : Model -> User
createUser model = 
    { name = model.inputName 
    }


type Styles = 
    None
    | Error
    | Container 
    | Title
    | Form 
    | FormLabel
    | FormInput
    | Submit
    | Table 
    | Tr
    | TableHeader


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ Style.style Container 
            [ Font.typeface sansSerif
            ]
        , Style.style Title 
            [ Font.size 30 
            , Color.text red
            , Background.gradientDown [ Background.step Color.blue, Background.step Color.green ]
            ]
        , Style.style Form []
        , Style.style FormLabel 
            [ Color.background gray
            , Border.roundBottomLeft 5
            , Border.roundTopLeft 5
            , Border.all 1
            , Color.border blue
            ]
        , Style.style FormInput 
            [ Border.roundBottomRight 5
            , Border.roundTopRight 5
            , Border.solid
            , Border.all 1
            , Color.text blue
            ]
        , Style.style Submit 
            [ Color.background green
            , Color.text white
            , Border.all 1
            , Border.rounded 5
            , Font.bold
            ]
        , Style.style None []
        , Style.style Error 
            [ Color.text red
            ]
        , Style.style TableHeader 
            [ Color.background gray
            , Color.border blue
            , Border.all 1
            ]
        , Style.style Tr 
            [ Border.bottom 1
            , Color.border blue
            ]
        ]


toHtmlList : List PhoneNumber -> Html msg
toHtmlList phoneNumbers =
  ul [] (List.map toLi phoneNumbers)

toLi : PhoneNumber -> Html msg
toLi phone = 
  li [] [ Html.text ( phone.number ++ " " ++ phone.user.name ) ]