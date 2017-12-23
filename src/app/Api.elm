module Api exposing (..)

import Decoders exposing (decodeToken, decodeUser)
import Encoders
import Http exposing (jsonBody)
import Json.Decode
import Messages exposing (Msg)
import Models exposing (Form, Token, User)
import RemoteData

signUpUrl : String
signUpUrl =
    "https://nookit.eu.auth0.com/dbconnections/signup"


loginUrl : String
loginUrl =
    "https://nookit.eu.auth0.com/oauth/token"

fetchAccount : Form -> Cmd Msg
fetchAccount user =
    Http.post signUpUrl (jsonBody <| Encoders.signUp user) (Json.Decode.succeed ())
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchAccount


fetchToken : Form -> Cmd Msg
fetchToken form =
    Http.post loginUrl (jsonBody <| Encoders.login form) decodeToken
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchToken


authorisedRequest : Token -> Http.Request User
authorisedRequest token =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" <| "Bearer " ++ token.accessToken ]
        , url = "https://nookit.eu.auth0.com/userinfo"
        , body = Http.emptyBody
        , expect = Http.expectJson decodeUser
        , timeout = Nothing
        , withCredentials = False
        }


fetchUser : Token -> Cmd Msg
fetchUser token =
    authorisedRequest token
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchUser

