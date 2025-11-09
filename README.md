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

## Author's Reflection

### Which API did you choose and why?
I chose the OpenWeatherMap API for weather data and NewsAPI.org for news headlines. Both are popular, well-documented, and offer generous free tiers, making them ideal for a demo project. Using two different APIs also allowed me to showcase a more flexible and scalable architecture.

### How did you implement data fetching and JSON parsing?
I used the `dio` package for making HTTP requests and `retrofit` to create a type-safe client. This combination significantly reduces boilerplate and makes the API service layer clean and readable. For JSON parsing, I used the `json_serializable` package, which automatically generates the serialization logic. This approach is not only efficient but also less error-prone than manual parsing.

### What challenges did you face when handling errors or slow connections?
A key challenge was ensuring a smooth user experience even when network conditions are suboptimal. To address this, I implemented a loading state that provides visual feedback to the user while data is being fetched. For error handling, I used `try-catch` blocks to catch exceptions and display a user-friendly error message. A `finally` block ensures that the loading state is always reset, regardless of the outcome.

### How would you improve your app's UI or performance in future versions?
For future improvements, I would focus on enhancing the UI with more engaging animations and a more polished design. Performance-wise, I would implement a caching mechanism to store API responses, reducing the number of network requests and making the app feel faster. I would also add more robust error handling, such as distinguishing between different types of network errors and providing more specific feedback to the user.
