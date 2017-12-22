module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Messages exposing (..)
import Models exposing (Form, Post, User)
import Routes exposing (..)


layout : Html msg -> Html msg -> Html msg
layout header main =
    div []
        [ header, main ]


authHeader : Html msg
authHeader =
    header []
        [ nav []
            [ div [ class "nav-wrapper container" ]
                [ ul [ class "right" ]
                    [ li []
                        [ a [ href <| path LoginRoute, class "btn" ] [ text "Login" ] ]
                    , li []
                        [ a [ href <| path SignUpRoute, class "btn" ] [ text "Sign Up" ] ]
                    ]
                ]
            ]
        ]


postCard : Post -> Html Msg
postCard post =
    div [ class "col s12 m6 l4" ]
        [ div [ onClick <| UpdateRoute <| ReadPostRoute post.id, class "card small hoverable grey lighten-4" ]
            [ div [ class "card-content" ]
                [ span [ class "card-title medium" ]
                    [ text <| "ID " ++ post.id ++ ": " ++ post.title ]
                , p [] [ text post.body ]
                ]
            ]
        ]


landingBody : List Post -> Html Msg
landingBody posts =
    main_ [ class "container" ]
        [ List.map postCard posts
            |> div [ class "row" ]
        ]


readPostBody : Post -> Html msg
readPostBody post =
    main_ [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "col l6 offset-l3" ]
                [ h1 [] [ text <| "ID " ++ post.id ++ ": " ++ post.title ]
                , List.repeat 10 post.body |> List.map (\par -> p [] [ text par ]) |> div []
                ]
            ]
        ]


error : a -> Html msg
error a =
    main_ [ class "container" ] [ text <| toString a ]


userHeader : User -> Html Msg
userHeader user =
    header []
        [ nav []
            [ div [ class "nav-wrapper container" ]
                [ a [ href <| path CreatePostRoute, class "btn" ] [ text "New Post" ]
                , ul [ class "right" ]
                    [ li [] [ text user.email ]
                    , li [] [ a [ onClick Logout, class "btn" ] [ text "Logout" ] ]
                    ]
                ]
            ]
        ]


createPostBody : Form -> Html Msg
createPostBody form =
    main_ [ class "container " ]
        [ div [ class "row" ]
            [ Html.form [ class "col s12 m8 offset-m2" ]
                [ div [ class "input-field" ]
                    [ input
                        [ placeholder "Post Title"
                        , value form.postTitle
                        , type_ "text"
                        , onInput (\title -> OnInput { form | postTitle = title })
                        ]
                        []
                    ]
                , div [ class "input-field" ]
                    [ textarea
                        [ placeholder "Enter post here..."
                        , onInput (\body -> OnInput { form | postBody = body })
                        ]
                        [ text form.postBody ]
                    ]
                , a [ onClick CreatePost, class "btn right" ] [ text "Create" ]
                ]
            ]
        ]


emailInput : Form -> Html Msg
emailInput form =
    div [ class "input-field" ]
        [ i [ class "material-icons prefix" ] [ text "email" ]
        , input
            [ placeholder "Email"
            , type_ "text"
            , value form.email
            , onInput (\email -> OnInput { form | email = email })
            ]
            []
        ]


passwordInput : Form -> Html Msg
passwordInput form =
    div [ class "input-field" ]
        [ i [ class "material-icons prefix" ] [ text "lock" ]
        , input
            [ placeholder "Password"
            , value form.password
            , type_ "password"
            , onInput (\password -> OnInput { form | password = password })
            ]
            []
        ]


passwordAgain : Form -> Html Msg
passwordAgain form =
    div [ class "input-field" ]
        [ i [ class "material-icons prefix" ] [ text "lock" ]
        , input
            [ placeholder "Password Again"
            , value form.passwordAgain
            , type_ "password"
            , onInput (\again -> OnInput { form | passwordAgain = again })
            ]
            []
        ]


authentication : List (Html Msg) -> Html Msg
authentication body =
    main_ [ class "container " ]
        [ div [ class "full-height row valign-wrapper" ]
            [ Html.form [ class "col s12 m4 offset-m4" ]
                body
            ]
        ]


login : Form -> Html Msg
login form =
    authentication
        [ emailInput form
        , passwordInput form
        , a [ onClick Login, class "btn right" ] [ text "Login" ]
        ]


signUp : Form -> Html Msg
signUp form =
    authentication
        [ emailInput form
        , passwordInput form
        , passwordAgain form
        , a [ onClick SignUp, class "btn right" ] [ text "Sign Up" ]
        ]
