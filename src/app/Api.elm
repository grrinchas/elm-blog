module Api exposing (..)

import Decoders exposing (decodeToken, decodeUser)
import Encoders
import Http exposing (jsonBody)
import Json.Decode
import Messages exposing (Msg)
import Models exposing (Form, Token, User)
import RemoteData


domain: String
domain = "https://nookit.eu.auth0.com"


fetchAccount : Form -> Cmd Msg
fetchAccount user =
    Http.post (domain ++ "/dbconnections/signup") (jsonBody <| Encoders.signUp user) (Json.Decode.succeed ())
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchAccount



fetchToken : Form -> Cmd Msg
fetchToken form =
    Http.post (domain ++ "/oauth/token") (jsonBody <| Encoders.login form) decodeToken
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchToken


authorisedRequest : Token -> Http.Request User
authorisedRequest token =
    Http.request
        { method = "GET"
        , headers = [ Http.header "Authorization" <| "Bearer " ++ token.accessToken ]
        , url = domain ++ "/userinfo"
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

