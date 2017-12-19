module Models exposing (..)

import Lorem


type alias Post =
    { id: String
    , title : String
    , body : String
    }


type alias Model =
    { posts: List Post
    }


initialModel : Model
initialModel =
    { posts = List.range 1 10 |> List.map toString |> List.map initialPost
    }


initialPost : String -> Post
initialPost id =
    { id = id
    , title = Lorem.sentence 4
    , body = Lorem.paragraphs 2 |> String.concat
    }






