module Models exposing (..)

import Lorem
import Routes exposing (Route(HomeRoute))


type alias User =
    { email : String
    , logged : Bool
    }


type alias Post =
    { id : String
    , title : String
    , body : List String
    }


type alias Model =
    { posts : List Post
    , user : User
    , route: Route
    }


initial : Model
initial =
    { posts = List.map initialPost <| List.range 1 10
    , user = { email = "email@gmail.com", logged = False }
    , route =  HomeRoute
    }


initialPost : Int -> Post
initialPost id =
    { id = toString id, title = "Post  " ++ toString id ++ ": " ++ Lorem.sentence 6, body = Lorem.paragraphs 20 }
