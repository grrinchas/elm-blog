module Models exposing (..)

import Lorem
import RemoteData exposing (RemoteData(NotAsked), WebData)
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

type alias Token =
    { accessToken : String
    , idToken : String
    , tokenType : String
    , expiresIn : Int
    }

type alias Model =
    { posts : List Post
    , form : Form
    , route : Route
    , user : WebData User
    , token : WebData Token
    , account : WebData ()
    }


initialModel : Model
initialModel =
    { posts = List.range 1 10 |> List.map toString |> List.map initialPost
    , form = initialForm
    , route = HomeRoute
    , user = NotAsked
    , token = NotAsked
    , account = NotAsked
    }

initialForm : Form
initialForm =  { email = "", password = "", passwordAgain = "", postTitle = "", postBody = "" }

initialPost : String -> Post
initialPost id =
    { id = id
    , title = Lorem.sentence 4
    , body = Lorem.paragraphs 2 |> String.concat
    }

