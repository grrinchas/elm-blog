module Api exposing (..)

import Decoders exposing (decodeToken)
import Encoders
import Http exposing (jsonBody)
import Json.Decode
import Messages exposing (Msg)
import Models exposing (Form)
import RemoteData

signUpUrl : String
signUpUrl =
    "https://nookit.eu.auth0.com/dbconnections/signup"


loginUrl : String
loginUrl =
    "https://nookit.eu.auth0.com/oauth/token"

signUp : Form -> Cmd Msg
signUp user =
    Http.post signUpUrl (jsonBody <| Encoders.signUp user) Json.Decode.string
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnUserSignUp


login : Form -> Cmd Msg
login form =
    Http.post loginUrl (jsonBody <| Encoders.login form) decodeToken
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnUserLogin
