module Decoders exposing (..)

import Json.Decode as Decoder
import Json.Decode.Pipeline as Pipeline
import Models exposing (Post, Token, User)

decodeToken : Decoder.Decoder Token
decodeToken =
    Pipeline.decode Token
        |> Pipeline.required "access_token" Decoder.string
        |> Pipeline.required "id_token" Decoder.string
        |> Pipeline.required "token_type" Decoder.string
        |> Pipeline.required "expires_in" Decoder.int


decodeUser : Decoder.Decoder User
decodeUser =
    Pipeline.decode User
        |> Pipeline.required "email" Decoder.string



decodePosts : Decoder.Decoder (List Post)
decodePosts =
    Decoder.list decodePost
        |> Decoder.field "allPosts"
        |> Decoder.field "data"


decodePost : Decoder.Decoder Post
decodePost =
    Pipeline.decode Post
        |> Pipeline.required "id" Decoder.string
        |> Pipeline.required "title" Decoder.string
        |> Pipeline.required "body" Decoder.string



decodeGraphcoolToken : Decoder.Decoder String
decodeGraphcoolToken =
    Decoder.string
        |> Decoder.field "token"
        |> Decoder.field "authenticate"
        |> Decoder.field "data"




