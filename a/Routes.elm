module Routes exposing (..)

import Navigation exposing (Location)
import RemoteData exposing (WebData)
import UrlParser exposing (Parser, map, oneOf, parseHash, s, string, top, (</>))

type Route
    = HomeRoute
    | ReadPostRoute String
    | CreatePostRoute
    | SignUpRoute
    | LoginRoute
    | ErrorRoute


parseLocation : Location -> Route
parseLocation location =
    case parseHash matchers location of
        Just route ->
            route

        Nothing ->
            ErrorRoute


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ map HomeRoute top
        , map HomeRoute (s "posts")
        , map ReadPostRoute (s "posts" </> string)
        , map CreatePostRoute (s "post")
        , map SignUpRoute (s "signup")
        , map LoginRoute (s "login")
        , map ErrorRoute (s "error")
        ]



toPath : Route -> String
toPath route =
    case route of
        HomeRoute ->
            "#"

        ReadPostRoute id ->
            "#posts/" ++ id

        CreatePostRoute ->
            "#post"

        SignUpRoute ->
            "#signup"

        LoginRoute ->
            "#login"

        ErrorRoute ->
            "#error"
