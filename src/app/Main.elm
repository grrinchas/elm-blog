module Main exposing (main)

import Api
import Messages exposing (..)
import Models exposing (..)
import Navigation exposing (Location, modifyUrl)
import Pages
import Persistence
import Platform.Cmd exposing (batch)
import RemoteData exposing (RemoteData(Loading, Success), WebData)
import Routes exposing (..)


main : Program (Maybe Token) Model Msg
main =
    Navigation.programWithFlags OnLocationChange
        { init = init
        , view = Pages.view
        , update = update
        , subscriptions = \model -> Persistence.get OnLoadToken
        }

init : Maybe Token -> Location -> ( Model, Cmd Msg )
init token location =
    let model =
       { initialModel
           | token = Maybe.map RemoteData.succeed token |> Maybe.withDefault RemoteData.NotAsked
           , route = parseLocation location
       }

    in
       let _ = Debug.log "Initial token: " model.token  in
    fetchUser model |> Tuple.mapSecond batch



reroute : Model -> ( Model, List (Cmd msg) )
reroute model =
    case ( model.route, RemoteData.isSuccess model.user ) of
        ( LoginRoute, True ) ->
            ( model, [ Navigation.modifyUrl <| path HomeRoute ] )

        ( SignUpRoute, True ) ->
            ( model, [ Navigation.modifyUrl <| path HomeRoute ] )

        ( CreatePostRoute, False ) ->
            ( { model | route = ErrorRoute }, [ Cmd.none ] )

        _ ->
            ( model, [ Cmd.none ] )


andThen : (a -> ( b, List c )) -> ( a, List c ) -> ( b, List c )
andThen apply ( a, c ) = let ( b, d ) = apply a in ( b, c ++ d )



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
        ( { model | posts = (::) post model.posts }, [] )



resetForm : Model -> ( Model, List (Cmd msg) )
resetForm model =
    ( { model | form = { email = "", password = "", passwordAgain = "", postTitle = "", postBody = "" } }, [] )



removeToken : Model -> ( Model, List (Cmd msg) )
removeToken model = (model, [Persistence.put Nothing])


saveToken : Model -> ( Model, List (Cmd msg) )
saveToken model = let _ = Debug.log "Save token: " model.token in
    (model, [Persistence.put <| RemoteData.toMaybe model.token])


fetchUser : Model -> (Model, List (Cmd Msg))
fetchUser model =
    case model.token of
        Success tok -> ( { model | user = RemoteData.Loading}, [Api.fetchUser tok])
        _ -> (model, [])


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnLocationChange location ->
            ( { model | route = parseLocation location }, [] )
                |> andThen reroute
                |> Tuple.mapSecond batch

        UpdateRoute route ->
            updateRoute route model
                |> Tuple.mapSecond batch

        OnInput form ->
            ( { model | form = form }, Cmd.none )

        CreatePost ->
            createPost model
                |> andThen resetForm
                |> andThen (updateRoute HomeRoute)
                |> Tuple.mapSecond batch

        Logout ->
            ( { model | user = RemoteData.NotAsked }, [] )
                |> andThen removeToken
                |> andThen (updateRoute HomeRoute)
                |> Tuple.mapSecond batch

        SignUp ->
            ({ model | account = RemoteData.Loading }, Api.fetchAccount model.form)

        Login ->
            ({ model | token = RemoteData.Loading }, Api.fetchToken model.form)

        OnFetchAccount account ->
            case account of
                Success _ ->
                    ( { model | account = account },  [])
                        |> andThen resetForm
                        |> andThen (updateRoute LoginRoute)
                        |> Tuple.mapSecond batch
                _ ->
                    ( { model | account = account },  Cmd.none)


        OnFetchToken token ->
                ({model | token = token}, [])
                    |> andThen saveToken
                    |> andThen fetchUser
                    |> Tuple.mapSecond batch



        OnFetchUser user ->
            case user of
                Success _ ->
                    ( { model | user = user},  [] )
                        |> andThen resetForm
                        |> andThen reroute
                        |> Tuple.mapSecond batch
                _ ->
                    ( { model | user = user},  Cmd.none)


        OnLoadToken token ->
            let _ = Debug.log "ON LOAD TOKEN: " token in
            ( { model | token = Maybe.map RemoteData.succeed token |> Maybe.withDefault RemoteData.NotAsked }, Cmd.none )











