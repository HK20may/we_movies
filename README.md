# We Movies

This is a Flutter application that allows users to browse and search for movies. It fetches movie data from an API and displays it in two sections: "Now Playing" and "Top Rated." The app also provides features such as location-based address fetching, search functionality, pagination, offline caching, and pull-to-refresh.



## Project Setup

To get started, you will need to have Flutter installed on your machine. You can find instructions on how to install Flutter [here](https://docs.flutter.dev/get-started/install)

```bash
  Flutter pub get
```


## Project Setup

Clone the project

```bash
  git clone https://github.com/HK20may/we_movies.git
```

Go to the project directory

```bash
  cd my-project
```

Get dependencies

```bash
  flutter pub get
```

Generate files

```bash
  flutter run build_runner build --delete-conflicting-outputs
```

Run the app

```bash
  flutter run
```


## Project Overview

<p>
  <img src="https://github.com/HK20may/we_movies/blob/master/assets/ss/splash.png" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/HK20may/we_movies/blob/master/assets/ss/location.png" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/HK20may/we_movies/blob/master/assets/ss/home_1.png" height= 400 width= 200 hspace="1"/>
  <img src="https://github.com/HK20may/we_movies/blob/master/assets/ss/home_2.png" height= 400 width= 200 hspace="1"/>
</p>


## Features

- **Fetching Location**: Fetching user location and reverse geocoding to get the user's primary and secondary address.
- **Now Playing Movies**: Displays a paginated list of currently playing movies.
- **Top Rated Movies**: Displays a paginated list of top-rated movies.
- **Local Search**: Filters movies based on search text.
- **Pagination: Supports loading additional pages of movies in both sections.
- **Offline Caching**: Stores fetched movie data for subsequent offline access.
- **Pull-to-Refresh**: Refreshes movie listings.
- **Error Handling**: Displays appropriate error messages in case of search failures or network issues.

## Folder Structure

```bash
app
├── android
├── ios
├── assets
├── ios
├── lib
│   ├── core
│   │   ├── app_components
│   │   ├── helpers
│   │   ├── utils
│   │   ├── web_services
│   │   ├── widgets
│   ├── database
│   │   ├── shared_preference
│   ├── feature
│   │   ├── home
│   │   |  ├── cubit
│   │   |  ├── data
│   │   |  ├── presentation
│   we_work_app.dart
│   main.dart
├── test
├── README.MD
├── pubspec.yaml
└── .gitignore
```


