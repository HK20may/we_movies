# We Movies

This is a Flutter application that allows users to browse and search for movies. It fetches movie data from an API and displays it in two sections: "Now Playing" and "Top Rated." The app also provides features such as location-based address fetching, search functionality, pagination, offline caching, and pull-to-refresh.
[APK link](https://drive.google.com/file/d/1UYkI7cCb5wpbT7i-8gDVFX64dMPYRKhJ/view?usp=sharing) 



## Project Setup

To get started, you will need to have Flutter installed on your machine. You can find instructions on how to install Flutter [here](https://docs.flutter.dev/get-started/install)

| | |
| :-------- | :------- |
| Flutter version  | 3.19.6 |
| Dart version  | 3.3.4 |


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
- **Pagination**: Supports loading additional pages of movies in both sections.
- **Offline Caching**: Stores fetched movie data for subsequent offline access.
- **Pull-to-Refresh**: Refreshes movie listings.
- **Error Handling**: Displays appropriate error messages in case of search failures or network issues.

***

## Architecture
### Customized Clean Architecture

The architecture of the  App follows a customized clean architecture, tailored to meet the specific needs and complexity of the application. While traditional clean architecture emphasizes abstraction and separation of concerns through distinct layers, my approach prioritizes simplicity and readability while maintaining independence between layers.

**Key Components:**

**1. Presentation Layer:** 

* Communicates directly with the business logic layer.

* Responsible for rendering UI components and handling user interactions.

**2. Business Logic Layer:** 

* Acts as an intermediary between the presentation layer and the repository.

* Implements business rules and logic.

* Orchestrates the flow of data within the application.


**3. Repository Layer:** 

* Handles data access and storage.

* Communicates with external data sources such as web services.

* Provides a unified interface for accessing data regardless of the underlying source.

**4. Services:** 

* Acts as a bridge between the repository layer and external data sources.

* Responsible for fetching data from core web services and processing it.

**Communication Flow:**

* The presentation layer interacts with the business logic layer to request and receive data.

* The business logic layer communicates with the repository layer to fetch or store data.

* The repository layer interfaces with services to access external data sources.

* Data flows from core web services through services, repository, business logic, and finally to the presentation layer in the form of models.

**Benefits:**

* **Simplicity and Readability:** By avoiding excessive abstraction, the architecture remains straightforward and easy to understand, facilitating faster development and maintenance.

* **Independence of Layers:** Each layer operates independently, allowing for easier testing, debugging, and modification without affecting other parts of the application.

*  **Scalability:** While tailored for the current scale of the application, the architecture provides a foundation for future scalability and expansion.

**Considerations:**

* **Complexity Management:** The architecture strikes a balance between abstraction and simplicity, suitable for the current size and complexity of the app. Consider introducing abstraction as the app grows to handle increased complexity effectively.

* **Adaptability:** Continuously evaluate and refine the architecture to align with evolving project requirements and best practices in software development.


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
│   │   │  ├── cubit
│   │   │  ├── data
│   │   │  ├── presentation
│   we_work_app.dart
│   main.dart
├── test
├── README.MD
├── pubspec.yaml
└── .gitignore
```

***


The project follows a modular and layered architecture, promoting separation of concerns and code organization. The folder structure is divided into three main segments:

***core***: 

The core segment encapsulates essential components vital for the app's functionality and coherence. It fosters independence and reusability across different modules.

* app_constants: Holds various constants used throughout the application, such as asset paths, colors, and string literals.

    - App Assets: Centralizes asset paths used within the app.
    - App Colors: Curates a palette of colors employed across various UI elements.
    - String Constants: Manages constant strings utilized throughout the application.


* helpers: Provides fundamental helper functionalities crucial for app operations. This includes:

    - API Helpers: Orchestrates API calls with methods, endpoints, and customized logging interceptors.
    - Logger: Employs an error reporter to facilitate error tracking and management.
    - Route Helper: Facilitates streamlined navigation through the app with customized routing mechanisms, eliminating the need for external packages.

* utils: Hosts utility services catering to miscellaneous requirements within the app, such as date conversion utilities.

* web_services: Encapsulates the API endpoints and web service configurations.

* widgets: Centralizes reusable UI components, enhancing code modularity and promoting component-based development. This includes: loading, buttons, error widgets, toast, etc.

***database***

The database segment encompasses all local storage components essential for persistent data management within the app.

* shared_preference: Manages app-specific preferences and settings, offering seamless access to locally stored data.

***feature***
Feature modules represent distinct sections or functionalities within the app, each containing its own set of logic, data, and presentation layers.

* home:

    -> cubit: Implements the business logic using the BLoC pattern, separating it from the presentation layer.

    -> data: Encapsulates models, repositories, and services responsible for data management and communication with the business logic.

    -> presentation:  Curates UI components tailored for the home screen, ensuring a cohesive and intuitive user experience.

* splash

This folder structure adheres to the principles of modular design, separation of concerns, and layered architecture. The core folder provides a centralized location for shared functionality, promoting code reuse and maintainability. The database folder encapsulates local storage mechanisms, while the feature folder follows a feature-driven approach, with each module being self-contained and organized into separate layers (presentation, business logic, and data).
By separating concerns and adhering to modular design principles, the codebase becomes more maintainable, testable, and scalable. Changes within a specific feature or module have minimal impact on other parts of the application, and new features can be added or existing ones can be modified with relative ease.

***

## Libraries Or Packages Used

* core packages

    [dio: 5.4.3+1](https://pub.dev/packages/dio) 
    
    [flutter_bloc: ^8.1.5](https://pub.dev/packages/flutter_bloc)

    [equatable: ^2.0.5](https://pub.dev/packages/equatable)

    [intl: ^0.19.0](https://pub.dev/packages/intl)

    [connectivity_plus: ^5.0.2](https://pub.dev/packages/connectivity_plus)

* ui packages

    [gap: ^3.0.1](https://pub.dev/packages/gap)

    [fluttertoast: ^8.2.4](https://pub.dev/packages/fluttertoast)

    [flutter_svg: ^2.0.10+1](https://pub.dev/packages/flutter_svg)

    [shimmer: ^3.0.0](https://pub.dev/packages/shimmer)

    [lottie: ^3.1.0](https://pub.dev/packages/lottie)

    [cached_network_image: ^3.3.1](https://pub.dev/packages/cached_network_image)

* location

    [geocoding: ^3.0.0](https://pub.dev/packages/geocoding)

    [geolocator: ^11.0.0](https://pub.dev/packages/geolocator)

* database

    [shared_preferences: ^2.2.3](https://pub.dev/packages/shared_preferences)

***
***
