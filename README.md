# Instaflix

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description

Social iOS app that makes communication easier with other users regarding on the topic of movies.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Social
- **Mobile:** Can be used on the go, and anywhere, the UI is simple and does not require much focus to use.
- **Story:** Connect and talk with your friends or around the world about movies. Watch movie trailers and comment about it with everyone!
- **Market:** No in-app purchases
- **Habit:** Multiple uses per day.
- **Scope:** Movie watchers, Socialize

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] As a user, I should be able to remain logged in across restarts.
- [X] As a new user, I should be able to create a new account for Instaflix.
- [X] As a user, I should be able to sign in into my account and view the home page.
- [X] As a user, I should be able to sign out from my account and return to the login page.
- [ ] As a user, I should be able to view movies in an organized fashion.
- [ ] As a user, I should be able to search movies using a search bar so that finding movies becomes easier.
- [ ] As a user, I should be able to comment about the movies.
- [ ] As a user, I should watch movie trailers of the chosen movie so I learn more about it.
- [ ] As a developer, I want to store movie trailer data, movie poster data, movie title data, movie description data for the display movie screen.
- [ ] As a developer, I want to link user accounts with comments displayed in the display movie screen.


**Optional Nice-to-have Stories**

- [ ] As a user, I should be able to delete my account.
- [ ] As a user, I should be able to add movies as favorite.
- [ ] As a user, I should be able to share favorite movies.
- [ ] As a user, I should be able to view their favorite movies.
- [ ] As a user, I should be able to delete its own account.
- [ ] As a user, I should be able to customize its own profile.

### 2. Screen Archetypes

* Account Log In/ Sign Up Screen
   * As a user, I should be able to create an account.
   * As a user, I should be able to remain logged in across restarts.
* Account Customization
   * As a user, I should be able to delete my account.
   * As a user, I should be able to customize my profile.   
* Home Screen
   * As a user, I should be able to view movies in an organized fashion.
   * As a user, I should be able to search for desired movie [Search].
   * As a user, I should be able to add comments to movies.
* Movie Display Screen
   * As a user, I should be able watch movie trailer of chosen movie.
   * As a user, I should be able to comment about the movies.
* Favorites
   * As a user, I should be able to add movies as favorite.
   * As a user, I should be able to share favorite movies.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Account
* Home
* Search

**Flow Navigation** (Screen to Screen)

* Account log in/sign up
   * First screen launch.
   * User Sign out.
* Account Settings
   * User presses Account Tab.
* Home
   * After user logs in
   * User presses on Home Tab.
   * User presses back button.
* Favorites
   * User presses Favorites * on Home Screen
   * User finishes sharing a Favorite
* Search
   * User presses on Search Tab.
   * User presses the back button if the last screen was the search screen while the user is in the movie display screen.
* Movie Display
   * After the user searches for an item, User then click on the item.
   * At the Home screen, the user presses any of the movies available. 

## Wireframes

Home

<img src="https://github.com/Instaflix/Instaflix/blob/main/Wireframes/Base%20Home%20App.drawio.png" width=150 height=200>

Home Alt

<img src="https://github.com/Instaflix/Instaflix/blob/main/Wireframes/Base%20Home%20App(Variant%202).drawio.png" width=150 height=200>

Favorites

<img src="https://github.com/Instaflix/Instaflix/blob/main/Wireframes/Screen Shot 2021-11-01 at 1.51.51 PM.png" width=150 height=200>

Movie

<img src="https://github.com/Instaflix/Instaflix/blob/main/Wireframes/Movie.drawio.png" width=150 height=200>

Movie Alt

<img src="https://github.com/Instaflix/Instaflix/blob/main/Wireframes/Movie(Variant%202).drawio.png" width=150 height=200>

Search

<img src="https://github.com/Instaflix/Instaflix/blob/main/Wireframes/Search.drawio.png" width=150 height=200>

Account Customization

<img src="https://github.com/Instaflix/Instaflix/blob/main/Wireframes/Acount%20Costumization.drawio.png" width=150 height=200>

Account Customization Alt

<img src="https://github.com/Instaflix/Instaflix/blob/main/Wireframes/Screen Shot 2021-11-01 at 1.37.03 PM.png" width=150 height=200>

HackMD Link:
https://hackmd.io/@8y_u_aeZTP2uj_P7dsoqLA/r1WmhjpLF

## Schema 
### Models

Note: the ? in the name stands for nil/null properties. That it can be null.

#### Posts
| Property | Type | Description |
| ---------- | ------ | -------------- |
| objectId | String | self id of the object |
| author | String | author of the post, must be an existing user, objectId of user |
| text | String | text of the post |
| image? | File | Image added to the post |
| createdAt | DateTime | created time of the post |
| comment | Array | comments associated with the post | 

#### User
| Property | Type | Description |
| ---------- | ------ | -------------- |
| objectId | String | self id of the object |
| username | String | username of the user |
| password | String | password of the user |
| profilePicture? | File | an image of the user submitted profile picture |
| profileDescription? | String | description of the profile of the user |
| createdAt | DateTime | created time of the user |

#### Movie
| Property | Type | Description |
| ---------- | ------ | -------------- |
| objectId | String | self id of the object |
| user | String | objectId of user |
| movieId | String | official api movie id |
| poster | String | official api movie poster link |
| synopsis | String | official api movie sypnosis link |
| background | String | official api movie background link |
| trailer | String | official api movie trailer link |

#### Comments
| Property | Type | Description |
| ---------- | ------ | -------------- |
| objectId | String | self id of the object |
| author | String | author of the comment, must be an existing user, objectId of user |
| text | String | text of the post |
| image? | File | Image added to the post |
| createdAt | DateTime | created time of the post |
| post | String | post associated with the current comment | 

### Networking

* App Delegate connect apis:
```
// Parse Connection API 
let configuration = ParseClientConfiguration {
    $0.applicationId = "1aj9xzO1QdtzVl1snnZngTBBouoBKOf9AN6dUGG2"
    $0.clientKey = "v3hVzdztxTQonHIjJhANEGNG0fDCvBGwswxnnihQ"
    $0.server = "https://parseapi.back4app.com"
}
Parse.initialize(with: configuration)

```

* Account log in/sign up
   * (Create/POST) Creation of the account.
   * (Read/GET) Authentication process for sign in.
* Account Settings
   * (Update/POST) Update information of the user.
   * (Delete) Delete user account.
* Home
   * (Read/GET) Retrieve movie posters, movie title, and movie ids. 
* Favorites
   * (Read/GET) Retrieve movie posters, movie title, and movie ids. 
   * (Create/POST) create new entry for user's favorite list.
   * (Delete) delete/remove entry from user's favorite list.
* Search
   * (Read/POST) Retrieve list of movies based on search result
   * (Read/GET) Retrieve movie posters, movie title, and movie ids.
* Movie Display
   * (Read/GET) Retrieve movie posters, movie title, movie background, movie sypnosis, and movie ids.
    ```
   //seems useful to have: credits to George Kye (https://github.com/gkye/TheMovieDatabaseSwiftWrapper/)
   //Movie Title and information
   MovieMDB.movie(apikey, movieID: 7984, language: "en"){
      apiReturn, movie in
      if let movie = movie{
        print(movie.title)
        print(movie.revenue)
        print(movie.genres[0].name)
        print(movie.production_companies?[0].name)
      }
    }

   ```
   ```
    //Movie Posters
    MovieMDB.images(apikey, movieID: 871, language: "en"){
      data, imgs in
      if let images = imgs{
        print(images.posters[0].file_path)
        //Backdrop & stills might return `nil`
        // print(images.stills[0].file_path)
        //print(images.backdrops[0].file_path)
      }
    }

   ```
   * (Read/GET) Retrieve movie trailer.
   ```
   //Movie Trailers
   MovieMDB.videos(apikey, movieID: 607, language: "en"){
      apiReturn, videos in
      if let videos = videos{
        for i in videos {
          //    print(i.site)
          print(i.key)
          print(i.name)
        }
      }
    }

   ```
### Sprint 1
Gif Demo
<img src="https://github.com/Instaflix/Instaflix/blob/main/Login%2C%20StayLoggedIn%20and%20Logout%20Stories.gif" width="172" height="360">
