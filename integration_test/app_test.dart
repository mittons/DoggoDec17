import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:integration_test/integration_test.dart';

import 'package:doggo_dec_17/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const ciRun = bool.fromEnvironment('CI', defaultValue: false);

  group('Run app', () {
    testWidgets('and simulate user flow', (widgetTester) async {
      // Start the app
      app.main();
      await widgetTester.pumpAndSettle();

      // Test the initial state
      // ----------------------------------------------------------------
      // | Expect to find all elements required of the initial state
      // ----------------------------------------------------------------

      // Correct appbar
      expect(find.widgetWithText(AppBar, "Doggo diversity display app ^-^"),
          findsOneWidget);

      // Correct "get breeds" button
      expect(
          find.widgetWithText(ElevatedButton, "Get List of Doggo Diversity!"),
          findsOneWidget);

      // Test state changes/navigation
      // ----------------------------------------------------------------
      // | Clicking the button to request dog breeds being listed
      // |   results in the list being fetched and displayed
      // ----------------------------------------------------------------

      // ---------------======================================---------------
      // | Expect - the list should now be displayed
      // ---------------======================================---------------
      // Expect - the list or its elements shouldn't be displayed initially
      expect(find.byType(ListTile), findsNothing);

      // Click the button
      await widgetTester.tap(
          find.widgetWithText(ElevatedButton, "Get List of Doggo Diversity!"));
      await widgetTester.pumpAndSettle();

      // ---------------======================================---------------
      // | Expect - the list should now be displayed
      // ---------------======================================---------------

      // If we are running with the CI flag set we can make the assumption that
      // - the REST service being tested against is a mock service run locally
      //   - we use the data provided by image mockdogapidec17:1.0.
      if (ciRun) {
        for (String dogBreed in [
          "Affenpinscher",
          "Afghan Hound",
          "African Hunting Dog"
        ]) {
          expect(find.widgetWithText(ListTile, dogBreed), findsOneWidget);
        }
      }
     });
  });
}
