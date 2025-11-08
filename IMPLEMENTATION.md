# Implementation Plan for APIConnectApp

This document outlines the phased implementation plan for creating the APIConnectApp.

## Journal

*Chronological log of actions, learnings, and deviations.*

*   **2025-11-09:**
    *   Created Flutter project `apiconnectapp`.
    *   Updated `pubspec.yaml` description.
    *   Added `dio`, `retrofit`, `provider`, `json_annotation` dependencies.
    *   Added `build_runner`, `retrofit_generator`, `json_serializable` dev dependencies.
    *   Created placeholder `README.md`.
    *   Created `CHANGELOG.md`.
    *   Created directory structure (`lib/models`, `lib/screens`, `lib/services`, `lib/viewmodels`, `lib/widgets`).
    *   Created initial `lib/main.dart`.
    *   `flutter analyze` showed no issues for `apiconnectapp`.
    *   **Deviation:** Could not remove `lib/main.dart` and `test/` directory using `rm` command due to unexpected path resolution issues. Proceeded with updating `pubspec.yaml` and creating new `main.dart`. The `test` directory was not removed.
    *   **Deviation:** Skipping git commit due to lack of direct git access.
*   **2025-11-09:**
    *   Created `lib/models/weather.dart` and `lib/models/article.dart`.
    *   Ran `build_runner` to generate `.g.dart` files for models.
    *   Created `lib/services/api_client.dart`, `lib/services/weather_api_service.dart`, `lib/services/news_api_service.dart`.
    *   Ran `build_runner` again to generate `retrofit` service implementations and update `.g.dart` files.
    *   Fixed analysis issues in `lib/services/weather_api_service.dart` (removed unused imports, added `@JsonKey` annotations, corrected `part` directive).
    *   Fixed `article_test.dart` to correctly test `NewsResponse` serialization by adding `explicitToJson: true` to `NewsResponse` in `article.dart` and regenerating `.g.dart` files.
    *   Created unit tests for `Weather` and `Article` models.
    *   All tests passed.
    *   `dart format .` was run.
    *   **Deviation:** Skipping git commit due to lack of direct git access.

---

**Instructions:** After completing a task, if you added any TODOs to the code or didn't fully implement anything, make sure to add new tasks so that you can come back and complete them later. After each phase, follow the verification and commit steps.

## Phase 1: Project Setup & Initialization

- [x] Create a new, empty Flutter project named `APIConnectApp` in the current directory. (Renamed to `apiconnectapp`)
- [ ] Remove the `lib/main.dart` and `test/` directory. (Skipped due to tool issues, new `main.dart` created)
- [x] Update the `description` in `pubspec.yaml` to "A Flutter app to display weather and news from online APIs." and set the `version` to `0.1.0`.
- [x] Add the following dependencies to `pubspec.yaml` using the `pub` tool:
    - `dio`
    - `retrofit`
    - `provider`
    - `json_annotation`
- [x] Add the following dev dependencies to `pubspec.yaml` using the `pub` tool:
    - `build_runner`
    - `retrofit_generator`
    - `json_serializable`
- [x] Create a placeholder `README.md` with a short description of the app.
- [x] Create a `CHANGELOG.md` file with the initial version `0.1.0`.
- [x] Create the directory structure as defined in `DESIGN.md`.
- [x] Create an initial `lib/main.dart` to set up the `MaterialApp` and `MultiProvider`.
- [ ] Commit the initial project structure to the current branch. (Skipped)
- [x] **Phase 1 Verification:**
    - [x] Run `flutter analyze` to ensure there are no analysis issues.
    - [ ] Run the app to ensure it launches without errors. (Skipped, cannot verify app launch)

## Phase 2: Data Models & API Services

- [x] Create the `lib/models/weather.dart` file with the `Weather` class, annotated for `json_serializable`.
- [x] Create the `lib/models/article.dart` file with the `Article` class, annotated for `json_serializable`.
- [x] Run `dart run build_runner build --delete-conflicting-outputs` to generate the `.g.dart` files for the models.
- [x] Create the `lib/services/api_client.dart` file to configure and instantiate the Dio client.
- [x] Create the `lib/services/weather_api_service.dart` file with the `WeatherApiService` abstract class, annotated for `retrofit`.
- [x] Create the `lib/services/news_api_service.dart` file with the `NewsApiService` abstract class, annotated for `retrofit`.
- [x] Run `dart run build_runner build --delete-conflicting-outputs` again to generate the `retrofit` service implementations.
- [x] **Phase 2 Verification:**
    - [x] Create unit tests for the models to verify `fromJson` and `toJson` work as expected.
    - [x] Run `dart_fix --apply`.
    - [x] Run `flutter analyze` and fix any issues.
    - [x] Run the tests to ensure they all pass.
    - [x] Run `dart format .`.
    - [ ] Review the `IMPLEMENTATION.md` file for any changes. (Done)
    - [x] Update the Journal in `IMPLEMENTATION.md`.
    - [ ] Use `git diff` to verify changes and commit with an appropriate message. (Skipped)

## Phase 3: ViewModels

- [ ] Implement the `lib/viewmodels/weather_viewmodel.dart` file with the `WeatherViewModel` class, extending `ChangeNotifier`.
- [ ] Implement the `lib/viewmodels/news_viewmodel.dart` file with the `NewsViewModel` class, extending `ChangeNotifier`.
- [ ] Add logic to the ViewModels to call the API services, handle loading states, and notify listeners.
- [ ] **Phase 3 Verification:**
    - [ ] Create unit tests for the ViewModels, mocking the API services to test the business logic.
    - [ ] Run `dart_fix --apply`.
    - [ ] Run `flutter analyze` and fix any issues.
    - [ ] Run all tests to ensure they pass.
    - [ ] Run `dart format .`.
    - [ ] Review the `IMPLEMENTATION.md` file for any changes.
    - [ ] Update the Journal in `IMPLEMENTATION.md`.
    - [ ] Use `git diff` to verify changes and commit with an appropriate message.

## Phase 4: UI Implementation

- [ ] Create the `lib/screens/home_screen.dart` with a `BottomNavigationBar` to manage the two tabs.
- [ ] Create the `lib/widgets/weather_display.dart` and `lib/widgets/article_tile.dart` stateless widgets.
- [ ] Implement the `lib/screens/weather_screen.dart`, including a `TextField` and a button to trigger the weather search.
- [ ] Implement the `lib/screens/news_screen.dart` with a `ListView.builder` to display the news articles.
- [ ] Connect the screens to their respective ViewModels using `Provider.of` or `Consumer` widgets to display data and loading indicators.
- [ ] **Phase 4 Verification:**
    - [ ] Create widget tests for the primary screens and widgets to verify the UI renders correctly in different states (loading, error, data).
    - [ ] Run `dart_fix --apply`.
    - [ ] Run `flutter analyze` and fix any issues.
    - [ ] Run all tests to ensure they pass.
    - [ ] Run `dart format .`.
    - [ ] Review the `IMPLEMENTATION.md` file for any changes.
    - [ ] Update the Journal in `IMPLEMENTATION.md`.
    - [ ] Use `git diff` to verify changes and commit with an appropriate message.
    - [ ] Use the `hot_reload` tool to see changes in the running app.

## Phase 5: Finalization

- [ ] Create a comprehensive `README.md` file for the package, including setup and usage instructions.
- [ ] Create a `GEMINI.md` file in the project directory that describes the app, its purpose, and implementation details of the application and the layout of the files.
- [ ] **Phase 5 Verification:**
    - [ ] Manually test the application to ensure all features work as expected.
    - [ ] Ask the user to inspect the app and the code and say if they are satisfied with it, or if any modifications are needed.
