module Messages exposing (..)

import Models exposing (User)
import Navigation exposing (Location)


type Msg
    = OnLocationChange Location
    | OnEmailEntered String
    | ONPasswordEntered String
    | OnRepeatEntered String
    | Login {email: String, password : String}
    | SignUp {email: String, password: String, repeat: String}
