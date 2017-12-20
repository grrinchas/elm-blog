module Messages exposing (..)

import Navigation exposing (Location)
import Routes exposing (Route)


type Msg
    = OnLocationChange Location
    | UpdateRoute Route

