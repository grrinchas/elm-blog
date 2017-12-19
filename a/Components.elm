module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (Post, User)


layout : Html msg -> Html msg -> Html msg
layout header main =
    div []
        [ header, main ]


error : a -> Html msg
error a =
    main_ [ class "container" ] [ text <| toString a ]


authHeader : Html msg
authHeader =
    header []
        [ nav []
            [ div [ class "nav-wrapper container" ]
                [ ul [ class "right" ]
                    [ li [] [ a [ href "#", class "btn" ] [ text "Login" ] ]
                    , li [] [ a [ href "#", class "btn" ] [ text "Sign Up" ] ]
                    ]
                ]
            ]
        ]


userHeader : User -> Html msg
userHeader user =
    header []
        [ nav []
            [ div [ class "nav-wrapper container" ]
                [ a [ href "#", class "btn" ] [ text "New Post" ]
                , ul [ class "right" ]
                    [ li [] [ text user.email ]
                    , li [] [ a [ href "#", class "btn" ] [ text "Logout" ] ]
                    ]
                ]
            ]
        ]


createPostBody : Html msg
createPostBody =
    main_ [ class "container " ]
        [ div [ class "full-height row valign-wrapper" ]
            [ Html.form [ class "col s12 m8 offset-m2" ]
                [ div [ class "input-field" ] [ input [ placeholder "PostTitle", type_ "text" ] [] ]
                , div [ class "input-field" ] [ textarea [ placeholder "Enter post here..." ] [] ]
                , a [ class "btn right" ] [ text "Create" ]
                ]
            ]
        ]


readPostBody : Post -> Html msg
readPostBody post =
    main_ [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "col m6 offset-m3" ]
                [ h1 [] [ text post.title ]
                , div [] <| List.map (\par -> p [] [ text par ]) post.body
                ]
            ]
        ]


landingBody : List Post -> Html msg
landingBody posts =
    let
        card =
            \post ->
                div [ class "col s12 m6 l4" ]
                    [ div [ class "card small hoverable grey lighten-4" ]
                        [ div [ class "card-content" ]
                            [ span [ class "card-title medium" ] [ text post.title ]
                            , p [] [ List.head post.body |> Maybe.withDefault "" |> text ]
                            ]
                        ]
                    ]
    in
        main_ [ class "container" ]
            [ div [ class "row" ] <| List.map card posts
            ]


login : Html msg
login =
    main_ [ class "container " ]
        [ div [ class "full-height row valign-wrapper" ]
            [ Html.form [ class "col s12 m4 offset-m4" ]
                [ div [ class "input-field" ]
                    [ i [ class "material-icons prefix" ] [ text "email" ]
                    , input [ placeholder "Email", type_ "text" ] []
                    ]
                , div [ class "input-field" ]
                    [ i [ class "material-icons prefix" ] [ text "lock" ]
                    , input [ placeholder "Password", type_ "password" ] []
                    ]
                , a [ class "btn right" ] [ text "Login" ]
                ]
            ]
        ]


signUp : Html msg
signUp =
    main_ [ class "container " ]
        [ div [ class "full-height row valign-wrapper" ]
            [ Html.form [ class "col s12 m4 offset-m4" ]
                [ div [ class "input-field" ]
                    [ i [ class "material-icons prefix" ] [ text "email" ]
                    , input [ placeholder "Email", type_ "text" ] []
                    ]
                , div [ class "input-field" ]
                    [ i [ class "material-icons prefix" ] [ text "lock" ]
                    , input [ placeholder "Password", type_ "password" ] []
                    ]
                , div [ class "input-field" ]
                    [ i [ class "material-icons prefix" ] [ text "lock" ]
                    , input [ placeholder "Password Again", type_ "password" ] []
                    ]
                , a [ class "btn right" ] [ text "Sign Up" ]
                ]
            ]
        ]
