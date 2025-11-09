# APIConnectApp

A Flutter application that demonstrates how to connect to online REST APIs, parse JSON data, and display it in a user-friendly interface. The app features both weather and news information, showcasing real-time data retrieval from the internet.

## Features

*   **Weather Display:** Get current weather conditions for a specified city using the OpenWeatherMap API.
*   **News Headlines:** View top news headlines from NewsAPI.org.
*   **API Integration:** Uses `retrofit` for type-safe HTTP requests and `json_serializable` for efficient JSON parsing.
*   **State Management:** Implements `provider` for reactive state management.
*   **Environment Variables:** Securely manages API keys using `flutter_dotenv`.

## Getting Started

### Prerequisites

*   Flutter SDK installed.
*   An API key from [OpenWeatherMap API](https://openweathermap.org/api).
*   An API key from [NewsAPI.org](https://newsapi.org/).

### Installation

1.  **Clone the repository:**
    ```bash
    git clone git@github.com:mejares-jamesmichael/DIT301-JMMejares-Act06.git
    cd apiconnectapp
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Create a `.env` file:**
    In the root of the project, create a file named `.env` and add your API keys:
    ```
    NEWS_API_KEY=YOUR_NEWSAPI_API_KEY
    OPENWEATHERMAP_API_KEY=YOUR_OPENWEATHERMAP_API_KEY
    ```
    Replace `YOUR_NEWSAPI_API_KEY` and `YOUR_OPENWEATHERMAP_API_KEY` with your actual API keys.

4.  **Generate code:**
    Run the build runner to generate necessary `.g.dart` files for `json_serializable` and `retrofit`:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

### Running the App

To run the application, use the following command:

```bash
flutter run
```

The app will launch on your connected device or emulator.

## Project Structure

```
lib/
├── main.dart                 # App entry point, MaterialApp, Provider setup
├── models/
│   ├── article.dart            # Data model for a news article
│   └── weather.dart            # Data model for weather data
├── screens/
│   ├── home_screen.dart        # Main screen with BottomNavigationBar
│   ├── news_screen.dart        # UI for the news list
│   └── weather_screen.dart     # UI for the weather display
├── services/
│   ├── api_client.dart         # Dio client setup and instance
│   ├── news_api.dart           # Retrofit service definition for News API
│   ├── news_api_service.dart   # NewsResponse and Article models
│   ├── weather_api.dart        # Retrofit service definition for Weather API
│   └── weather_api_service.dart# WeatherResponse, WeatherMain, WeatherCondition models
├── viewmodels/
│   ├── news_viewmodel.dart     # ChangeNotifier for news data and logic
│   └── weather_viewmodel.dart  # ChangeNotifier for weather data and logic
└── widgets/
    ├── article_tile.dart       # A reusable widget for a single news article
    └── weather_display.dart    # A reusable widget to show weather info
```
