module Api exposing (..)

import Decoders exposing (decodeGraphcoolToken, decodePosts, decodeToken, decodeUser)
import Encoders
import Http exposing (jsonBody, stringBody)
import Json.Decode
import Messages exposing (Msg)
import Models exposing (Form, Post, Token, User)
import RemoteData


graphcool: String
graphcool = "https://api.graph.cool/simple/v1/cjbm8w2980rge0186pld48aan"


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


fetchPosts: Cmd Msg
fetchPosts =
    Http.post graphcool (jsonBody <| Encoders.postsQuery) decodePosts
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchPosts


createRequest : Form -> String -> Http.Request Post
createRequest form token =
    Http.request
        { method = "POST"
        , headers = [ Http.header "Authorization" <| "Bearer " ++ token ]
        , url = graphcool
        , body = Http.jsonBody <| Encoders.createPost form
        , expect = Http.expectJson Decoders.decodePost
        , timeout = Nothing
        , withCredentials = False
        }


createPost : Form -> String -> Cmd Msg
createPost form token =
    createRequest form token
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnCreatePost


authenticate: Token -> Cmd Msg
authenticate token =
    Http.post graphcool (jsonBody <| Encoders.authenticate token) decodeGraphcoolToken
        |> RemoteData.sendRequest
        |> Cmd.map Messages.OnFetchGraphcoolToken



