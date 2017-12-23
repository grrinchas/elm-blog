module Messages exposing (..)

import Models exposing (Form, Token, User)
import Navigation exposing (Location)
import RemoteData exposing (WebData)
import Routes exposing (Route)


type Msg
    = OnLocationChange Location
    | UpdateRoute Route
    | OnInput Form
    | CreatePost
    | Login
    | Logout
    | SignUp
    | OnFetchAccount (WebData ())
    | OnFetchToken (WebData Token)
    | OnFetchUser (WebData User)
    | OnLoadToken (Maybe Token)



