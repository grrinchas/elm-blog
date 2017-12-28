module Main exposing (main)

import Api
import Messages exposing (..)
import Models exposing (..)
import Navigation exposing (Location, modifyUrl)
import Pages
import Persistence
import Platform.Cmd exposing (batch)
import RemoteData exposing (RemoteData(Failure, Loading, NotAsked, Success), WebData, isSuccess)
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
       fetchPosts model
            |> andThen fetchUser
            |> Tuple.mapSecond batch



fetchPosts: Model -> ( Model, List (Cmd Msg) )
fetchPosts model = (model, [Api.fetchPosts])


reroute : Model -> ( Model, List (Cmd msg) )
reroute model =
    case ( model.route, isSuccess model.user, isSuccess model.account) of
        ( SignUpRoute, False, True) ->
            ( { model | account = RemoteData.NotAsked }, [ Navigation.newUrl <| path LoginRoute ] )

        ( LoginRoute, True,  _) ->
            ( model, [ Navigation.modifyUrl <| path HomeRoute ] )

        ( SignUpRoute, True,  _) ->
            ( model, [ Navigation.modifyUrl <| path HomeRoute ] )

        ( CreatePostRoute, False,  _) ->
            ( { model | route = ErrorRoute }, [ Cmd.none ] )

        _ ->
            ( model, [ Cmd.none ] )


andThen : (a -> ( b, List c )) -> ( a, List c ) -> ( b, List c )
andThen apply ( a, c ) = let ( b, d ) = apply a in ( b, c ++ d )


resetForm : Model -> ( Model, List (Cmd msg) )
resetForm model =
    case (model.user, model.account) of
        (Success _, _) ->
            ({ model| form = initialForm }, [])
        (_, Success _) ->
            ({ model| form = initialForm }, [])
        _ -> (model, [])



removeToken : Model -> ( Model, List (Cmd msg) )
removeToken model = (model, [Persistence.put Nothing])


saveToken : Model -> ( Model, List (Cmd msg) )
saveToken model =
    (model, [Persistence.put <| RemoteData.toMaybe model.token])



fetchUser : Model -> (Model, List (Cmd Msg))
fetchUser model =
    case model.token of
        Success tok ->
            ( { model | user = RemoteData.Loading}, [Api.fetchUser tok])
        Failure err ->
            ( {model | user = RemoteData.Failure err}, [])
        _ -> (model, [])


updateRoute : Route -> Model -> (Model, List  (Cmd Msg))
updateRoute  route model = (model, [Navigation.newUrl <| path route ])


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
            ( model, RemoteData.map Api.authenticate model.token |> RemoteData.withDefault Cmd.none)

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
            ({ model | account = account }, [])
                |> andThen resetForm
                |> andThen reroute
                |> Tuple.mapSecond batch

        OnFetchToken token ->
            ({ model | token = token }, [])
                |> andThen saveToken
                |> andThen fetchUser
                |> Tuple.mapSecond batch

        OnFetchUser user ->
            ({ model | user = user },  [] )
                |> andThen resetForm
                |> andThen reroute
                |> Tuple.mapSecond batch

        OnFetchPosts posts ->
            ({ model | posts = posts }, Cmd.none )

        OnCreatePost post ->
             resetForm model
                 |> andThen fetchPosts
                 |> andThen (updateRoute HomeRoute)
                 |> Tuple.mapSecond batch

        OnFetchGraphcoolToken token ->
                (model, RemoteData.map (Api.createPost model.form ) token |> RemoteData.withDefault Cmd.none)


        OnLoadToken token ->
            ( { model | token = Maybe.map RemoteData.succeed token |> Maybe.withDefault RemoteData.NotAsked }, Cmd.none )











