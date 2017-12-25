module Encoders exposing (..)

import Models exposing (Form)
import Json.Encode as Encoder

clientId : String
clientId =
    "UjK2ISb0Bss3rQIgG2d7nroXalDs3cEW"


dbConnection : String
dbConnection = "db-connection"


signUp : Form -> Encoder.Value
signUp form =
    Encoder.object
        [ ( "client_id", Encoder.string clientId )
        , ( "email", Encoder.string form.email )
        , ( "password", Encoder.string form.password )
        , ( "connection", Encoder.string dbConnection )
        ]


login : Form -> Encoder.Value
login form =
    Encoder.object
        [ ( "client_id", Encoder.string clientId )
        , ( "password", Encoder.string form.password )
        , ( "username", Encoder.string form.email )
        , ( "grant_type", Encoder.string "password" )
        , ( "scope", Encoder.string "openid" )
        ]



