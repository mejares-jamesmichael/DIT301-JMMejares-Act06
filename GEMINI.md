# APIConnectApp - Gemini Project Documentation

This document provides an overview of the APIConnectApp, its purpose, and key implementation details, including the file layout.

## App Purpose

The APIConnectApp is a Flutter application designed to demonstrate the integration of external REST APIs to fetch and display real-time data. Specifically, it showcases how to retrieve weather information from the OpenWeatherMap API and news headlines from NewsAPI.org. The application emphasizes modern Flutter development practices, including:

*   **API Communication:** Utilizing `retrofit` for type-safe and declarative HTTP requests, built on top of `dio`.
*   **Data Serialization:** Employing `json_serializable` for efficient and automated JSON parsing into Dart objects.
*   **State Management:** Implementing `provider` with `ChangeNotifier` for a clear separation of concerns and reactive UI updates.
*   **Environment Variable Management:** Using `flutter_dotenv` to securely handle API keys, preventing them from being hardcoded in the source.

The app serves as a practical example for developers looking to build data-driven Flutter applications that interact with web services.

## Implementation Details

The application follows a layered architecture to ensure maintainability, scalability, and testability.

### Architecture Overview

The core architecture separates concerns into:
*   **Models:** Plain Dart objects representing the data fetched from APIs.
*   **Services:** Handles API communication, defining endpoints and making network requests.
*   **ViewModels:** Contains the business logic, fetches data from services, manages loading states, and notifies UI of changes.
*   **Screens:** Top-level UI components that compose widgets and interact with ViewModels.
*   **Widgets:** Reusable UI components.

### Key Technologies Used

*   **Flutter:** UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
*   **Dio:** A powerful HTTP client for Dart, used as the underlying client for Retrofit.
*   **Retrofit:** A type-safe HTTP client generator for Dart, simplifying API interface definitions.
*   **json_serializable:** A code generator for automatically converting Dart objects to/from JSON.
*   **Provider:** A state management solution for Flutter, used with `ChangeNotifier` for reactive updates.
*   **flutter_dotenv:** A package for loading environment variables from a `.env` file.
*   **Mockito:** A mocking framework for Dart, used for writing unit tests for ViewModels.

### File Layout

The project adheres to a feature-based and layered structure:

```
apiconnectapp/
├── .env                      # Environment variables (API keys)
├── lib/
│   ├── main.dart             # Application entry point, global providers, theme
│   ├── models/               # Data models for API responses
│   │   ├── article.dart      # Defines Article and NewsResponse classes
│   │   └── weather.dart      # Defines Weather, WeatherMain, WeatherCondition classes
│   ├── screens/              # Top-level UI screens
│   │   ├── home_screen.dart  # Main screen with BottomNavigationBar
│   │   ├── news_screen.dart  # Displays news headlines
│   │   └── weather_screen.dart# Displays weather information
│   ├── services/             # API service definitions and client setup
│   │   ├── api_client.dart   # Dio client instance
│   │   ├── news_api.dart     # Retrofit abstract class for News API endpoints
│   │   └── weather_api.dart  # Retrofit abstract class for Weather API endpoints
│   ├── viewmodels/           # Business logic and state management
│   │   ├── news_viewmodel.dart# Manages news data and state
│   │   └── weather_viewmodel.dart# Manages weather data and state
│   └── widgets/              # Reusable UI components
│       ├── article_tile.dart # Widget to display a single news article
│       └── weather_display.dart# Widget to display weather details
├── test/                     # Unit and widget tests
│   ├── models/               # Tests for data models
│   │   ├── article_test.dart
│   │   └── weather_test.dart
│   ├── screens/              # Tests for UI screens
│   │   ├── home_screen_test.dart
│   │   ├── news_screen_test.dart
│   │   └── weather_screen_test.dart
│   └── viewmodels/           # Tests for view models
│       ├── mocks.dart        # Manual mock classes for API services
│       ├── news_viewmodel_test.dart
│       └── weather_viewmodel_test.dart
├── pubspec.yaml              # Project dependencies and metadata
├── README.md                 # Project overview, setup, and usage
└── CHANGELOG.md              # Version history
```

## How to Extend

*   **Adding New APIs:** Define new abstract service classes using `retrofit` annotations, create corresponding data models with `json_serializable`, and implement new ViewModels to fetch and manage the data.
*   **New Features:** Add new screens and widgets, integrating them with existing or new ViewModels.
*   **Error Handling:** Enhance error handling in ViewModels and display more user-friendly messages in the UI.
*   **UI/UX Improvements:** Implement more sophisticated UI designs and animations.