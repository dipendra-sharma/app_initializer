import 'package:app_initializer/app_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AppInitializer shows splash screen during initialization',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      AppInitializer(
        splashBuilder: (context) => const Text('Splash'),
        application: const Text('App'),
        initializer: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
      ),
    );

    expect(find.text('Splash'), findsOneWidget);
    expect(find.text('App'), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    expect(find.text('Splash'), findsNothing);
    expect(find.text('App'), findsOneWidget);
  });

  testWidgets('AppInitializer shows error screen when initialization fails',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      AppInitializer(
        splashBuilder: (context) => const Text('Splash'),
        application: const Text('App'),
        errorBuilder: (context) => const Text('Error'),
        initializer: () async {
          throw Exception('Initialization failed');
        },
      ),
    );

    expect(find.text('Splash'), findsOneWidget);

    await tester.pump();

    expect(find.text('Splash'), findsNothing);
    expect(find.text('App'), findsNothing);
    expect(find.text('Error'), findsOneWidget);
  });
}
