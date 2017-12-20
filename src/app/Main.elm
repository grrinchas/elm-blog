module Main exposing (main)

import Messages exposing (..)
import Models exposing (..)
import Navigation exposing (Location, modifyUrl)
import Pages
import Platform.Cmd exposing (batch)
import Routes exposing (..)



main : Program Never Model Msg
main = Navigation.program OnLocationChange
        { init = \location -> ({initialModel | route = parseLocation location}, Cmd.none )
        , view =  Pages.view
        , update = update
        , subscriptions = \model -> Sub.none
        }


reroute: Model -> (Model, List (Cmd msg))
reroute model =
    case (model.route, model.user) of
        (CreatePostRoute, Nothing) ->
            (model, [Navigation.modifyUrl <| path ErrorRoute])

        (LoginRoute,  Just _)->
            (model, [Navigation.modifyUrl <| path HomeRoute])

        (SignUpRoute, Just _)->
            (model, [Navigation.modifyUrl <| path HomeRoute])
        _ ->
            (model, [Cmd.none])



andThen: (a -> (b, List c)) -> (a, List c) -> (b, List c)
andThen  apply (a, c) =
    let (b, c) = apply a in (b, c ++ c)


update: Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        OnLocationChange location ->
            ({model| route = parseLocation location}, [Cmd.none])
                |> andThen reroute
                |> Tuple.mapSecond batch

        UpdateRoute route ->
            (model, Navigation.newUrl <| path route)


