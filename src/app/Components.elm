module Components exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Models exposing (Post, User)


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
                    [ li [] [ a [class "btn" ] [ text "Login" ] ]
                    , li [] [ a [class "btn" ] [ text "Sign Up" ] ]
                    ]
                ]
            ]
        ]


landingBody : List Post -> Html msg
landingBody posts =
    main_ [ class "container" ]
        [ List.map postCard posts
          |> div [ class "row" ]
        ]



postCard : Post -> Html msg
postCard post =
    div [ class "col s12 m6 l4" ]
        [ div [ class "card small hoverable grey lighten-4" ]
             [ div [ class "card-content" ]
                [ span [ class "card-title medium" ]
                    [ text <| "ID " ++ post.id ++ ": "++ post.title ]
                , p [] [ text post.body ]
                ]
             ]
        ]



readPostBody : Post -> Html msg
readPostBody post =
    main_ [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "col l6 offset-l3" ]
                [ h1 [] [ text <| "ID " ++ post.id ++ ": "++ post.title  ]
                , List.repeat 10 post.body |> List.map (\par -> p [] [ text par ]) |> div []
                ]
            ]
        ]


error : a -> Html msg
error a =
    main_ [ class "container" ] [ text <| toString a ]



userHeader : User -> Html msg
userHeader user =
    header []
        [ nav []
            [ div [ class "nav-wrapper container" ]
                [ a [class "btn" ] [ text "New Post" ]
                , ul [ class "right" ]
                    [ li [] [ text user.email ]
                    , li [] [ a [class "btn" ] [ text "Logout" ] ]
                    ]
                ]
            ]
        ]



createPostBody : Html msg
createPostBody =
    main_ [ class "container " ]
        [ div [ class "row" ]
            [ Html.form [ class "col s12 m8 offset-m2" ]
                [ div [ class "input-field" ] [ input [ placeholder "Post Title", type_ "text" ] [] ]
                , div [ class "input-field" ] [ textarea [ placeholder "Enter post here..." ] [] ]
                , a [ class "btn right" ] [ text "Create" ]
                ]
            ]
        ]
