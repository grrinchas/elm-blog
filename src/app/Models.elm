module Models exposing (..)

import Lorem
import Routes exposing (Route(HomeRoute))


type alias User =
    { email : String
    }


type alias Post =
    { id : String
    , title : String
    , body : String
    }


type alias Form =
    { email : String
    , password : String
    , passwordAgain : String
    , postTitle : String
    , postBody : String
    }


type alias Model =
    { posts : List Post
    , user : Maybe User
    , route : Route
    , form : Form
    }


initialModel : Model
initialModel =
    { posts = List.range 1 10 |> List.map toString |> List.map initialPost
    , user = Nothing -- or Just { email = "email@gmail.com"}
    , route = HomeRoute
    , form = { email = "", password = "", passwordAgain = "", postTitle = "", postBody = "" }
    }


initialPost : String -> Post
initialPost id =
    { id = id
    , title = Lorem.sentence 4
    , body = Lorem.paragraphs 2 |> String.concat
    }
