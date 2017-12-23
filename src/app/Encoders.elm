module Encoders exposing (..)

import Decoders exposing (decodeUser)
import Http
import Messages
import Models exposing (Form, Token, User)

import Json.Encode as Encoder
import RemoteData

clientId : String
clientId =
    "UjK2ISb0Bss3rQIgG2d7nroXalDs3cEW"


signUp : Form -> Encoder.Value
signUp form =
    Encoder.object
        [ ( "client_id", Encoder.string clientId )
        , ( "email", Encoder.string form.email )
        , ( "password", Encoder.string form.password )
        , ( "connection", Encoder.string "db-connection" )
        ]



login : Form -> Encoder.Value
login form =
    let _ = Debug.log "" <| toString form in
    Encoder.object
        [ ( "client_id", Encoder.string clientId )
        , ( "password", Encoder.string form.password )
        , ( "username", Encoder.string form.email )
        , ( "grant_type", Encoder.string "password" )
        , ( "scope", Encoder.string "openid" )
        ]



