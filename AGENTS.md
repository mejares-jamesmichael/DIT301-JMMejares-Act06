# Agent Guidelines for APIConnectApp

## Build & Test Commands
- **Analyze**: `flutter analyze` - must pass with zero issues
- **Format**: `dart format .` - format all Dart files
- **Test all**: `flutter test`
- **Test single file**: `flutter test test/path/to/file_test.dart`
- **Generate code**: `flutter pub run build_runner build --delete-conflicting-outputs`
- **Run app**: `flutter run`

## Code Style
- **Imports**: Flutter/Dart first, then package imports, then relative imports (separated by blank lines)
- **Types**: Use explicit types for fields/parameters; use `late` for non-nullable fields initialized later
- **Naming**: camelCase for variables/methods, PascalCase for classes, snake_case for files
- **Formatting**: Use trailing commas for multi-line arguments/parameters
- **Error handling**: Use try-catch-finally; set error messages in catch, clear in finally
- **State management**: Use Provider with ChangeNotifier; private fields with public getters
- **API services**: Use Retrofit with @RestApi annotation; generate with build_runner
- **Models**: Use json_serializable with @JsonSerializable; include part directive for generated files
- **Testing**: Use mockito with @GenerateMocks annotation (NOT manual mock classes); import from `mocks.mocks.dart`
- **Test structure**: Wrap screens in `MaterialApp` + `Scaffold`; pass `apiKey: 'test-key'` to viewmodels in tests
- **Nullability**: Prefer non-nullable types; use `?` only when null is valid; check with `flutter analyze`

## Key Patterns
- ViewModels: Constructor injection for testability (e.g., `NewsViewModel({NewsApi? newsApi, String? apiKey})`)
- API calls: Fetch API keys from `dotenv.env['KEY_NAME']` with fallback to test keys
- Loading states: Set `_isLoading = true` before async, `false` in finally block
