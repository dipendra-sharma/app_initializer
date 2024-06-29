library app_initializer;

import 'package:flutter/widgets.dart';

/// A widget that handles the app initialization process.
///
/// This widget manages the flow of showing a splash screen during initialization,
/// transitioning to the main application after successful initialization,
/// and displaying an error screen if initialization fails.
class AppInitializer extends StatefulWidget {
  /// A function that returns the widget to be shown during initialization.
  final Widget Function(BuildContext context) splashBuilder;

  /// An optional function that returns a widget to be shown if initialization fails.
  final Widget Function(BuildContext context)? errorBuilder;

  /// The main application widget to be shown after successful initialization.
  final Widget application;

  /// An asynchronous function that performs the initialization tasks.
  final Future<void> Function() initializer;

  /// Creates an [AppInitializer] widget.
  ///
  /// The [splashBuilder], [application], and [initializer] parameters must not be null.
  const AppInitializer({
    super.key,
    required this.splashBuilder,
    required this.application,
    required this.initializer,
    this.errorBuilder,
  });

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _initializationFuture = widget.initializer();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError && widget.errorBuilder != null) {
            return widget.errorBuilder!(context);
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return widget.application;
        }
        return widget.splashBuilder(context);
      },
    );
  }
}
