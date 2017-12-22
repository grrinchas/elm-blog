module Main exposing (main)

import Messages exposing (..)
import Models exposing (..)
import Navigation exposing (Location, modifyUrl)
import Pages
import Platform.Cmd exposing (batch)
import Routes exposing (..)


main : Program Never Model Msg
main =
    Navigation.program OnLocationChange
        { init = \location -> ( { initialModel | route = parseLocation location }, Cmd.none )
        , view = Pages.view
        , update = update
        , subscriptions = \model -> Sub.none
        }


reroute : Model -> ( Model, List (Cmd msg) )
reroute model =
    case ( model.route, model.user ) of
        ( LoginRoute, Just _ ) ->
            ( model, [ Navigation.modifyUrl <| path HomeRoute ] )

        ( SignUpRoute, Just _ ) ->
            ( model, [ Navigation.modifyUrl <| path HomeRoute ] )

        ( CreatePostRoute, Nothing ) ->
            ( { model | route = ErrorRoute }, [ Cmd.none ] )

        _ ->
            ( model, [ Cmd.none ] )


andThen : (a -> ( b, List c )) -> ( a, List c ) -> ( b, List c )
andThen apply ( a, c ) =
    let
        ( b, c ) =
            apply a
    in
        ( b, c ++ c )


updateRoute : Route -> Model -> ( Model, List (Cmd msg) )
updateRoute route model =
    ( model, [ Navigation.newUrl <| path route ] )


createPost : Model -> ( Model, List (Cmd msg) )
createPost model =
    let
        post =
            { id = List.length model.posts + 1 |> toString
            , title = model.form.postTitle
            , body = model.form.postBody
            }
    in
        ( { model | posts = (::) post model.posts }, [ Cmd.none ] )


resetForm : Model -> ( Model, List (Cmd msg) )
resetForm model =
    ( { model | form = { email = "", password = "", passwordAgain = "", postTitle = "", postBody = "" } }, [ Cmd.none ] )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            ( { model | route = parseLocation location }, [ Cmd.none ] )
                |> andThen reroute
                |> Tuple.mapSecond batch

        UpdateRoute route ->
            updateRoute route model
                |> Tuple.mapSecond batch

        OnInput form ->
            ( { model | form = form }, Cmd.none )

        SignUp ->
            updateRoute LoginRoute model
                |> Tuple.mapSecond batch

        Login ->
            ( { model | user = Just { email = model.form.email } }, [ Cmd.none ] )
                |> andThen resetForm
                |> andThen reroute
                |> Tuple.mapSecond batch

        Logout ->
            ( { model | user = Nothing }, [ Cmd.none ] )
                |> andThen (updateRoute HomeRoute)
                |> Tuple.mapSecond batch

        CreatePost ->
            createPost model
                |> andThen resetForm
                |> andThen (updateRoute HomeRoute)
                |> Tuple.mapSecond batch
