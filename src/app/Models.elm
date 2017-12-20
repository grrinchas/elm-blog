module Models exposing (..)

import Lorem
import Routes exposing (Route(HomeRoute))

type alias User =
    { email : String
    }

type alias Post =
    { id: String
    , title : String
    , body : String
    }


type alias Model =
    { posts: List Post
    , user: User
    , route: Route      -- Added route
    }


initialModel : Model
initialModel =
    { posts = List.range 1 10 |> List.map toString |> List.map initialPost
    , user = { email = "email@gmail.com"}
    , route = HomeRoute -- Initialized route
    }


initialPost : String -> Post
initialPost id =
    { id = id
    , title = Lorem.sentence 4
    , body = Lorem.paragraphs 2 |> String.concat
    }






