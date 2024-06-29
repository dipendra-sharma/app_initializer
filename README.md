# Flutter App Initializer

A Flutter widget that streamlines app initialization, managing splash screens, async tasks, and error handling.

## Description

The Flutter App Initializer package offers a customizable `AppInitializer` widget that manages the app's initialization flow. It allows you to define a splash screen, an initialization process, and the main application widget. It also provides error handling capabilities, making it easy to show custom error screens when initialization fails.

## Features

- Show a custom splash screen during app initialization
- Handle asynchronous initialization tasks
- Seamlessly transition to your main app after initialization
- Display custom error screens if initialization fails
- Easy to integrate and customize

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_app_initializer: ^1.0.0
```

Then run:

```
$ flutter pub get
```

## Usage

Here's a basic example of how to use the `AppInitializer`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_app_initializer/flutter_app_initializer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppInitializer(
      splashBuilder: (context) => SplashScreen(),
      application: MainApp(),
      initializer: _initializeApp,
      errorBuilder: (context) => ErrorScreen(),
    );
  }

  Future<void> _initializeApp() async {
    // Perform initialization tasks here
    await Future.delayed(Duration(seconds: 2)); // Simulating some work
  }
}

// Define your SplashScreen, MainApp, and ErrorScreen widgets here
```

## API Reference

### AppInitializer

A widget that handles the app initialization process.

#### Constructor

```dart
const AppInitializer({
  Key? key,
  required Widget Function(BuildContext context) splashBuilder,
  required Widget application,
  required Future<void> Function() initializer,
  Widget Function(BuildContext context)? errorBuilder,
})
```

#### Parameters

- `splashBuilder`: A function that returns the widget to be shown during initialization.
- `application`: The main application widget to be shown after successful initialization.
- `initializer`: An asynchronous function that performs the initialization tasks.
- `errorBuilder`: An optional function that returns a widget to be shown if initialization fails.

## Examples

For more advanced usage and examples, check out the [example](example) folder in the package repository.

## Additional Information

For more information on using this package, please refer to the [API documentation](https://pub.dev/documentation/watchable/latest/).

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the BSD 3-Clause "New" or "Revised" License - see the [LICENSE](LICENSE) file for details.