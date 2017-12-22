module Messages exposing (..)

import Models exposing (Form)
import Navigation exposing (Location)
import Routes exposing (Route)


type Msg
    = OnLocationChange Location
    | UpdateRoute Route
    | OnInput Form
    | CreatePost
    | Login
    | Logout
    | SignUp
