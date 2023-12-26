import 'package:doggo_dec_17/models/doggo_service/doggo_breed.dart';
import 'package:doggo_dec_17/screens/doggo_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mock/mock_doggo_service.dart';

void main() {
  group('Doggo Screen', () {
    //
    testWidgets('contains all expected UI elements in initial state',
        (widgetTester) async {
      // Set up the services and environment resources needed for the widget being tested
      MockDoggoService mockDoggoService = MockDoggoService();

      // Init the widget
      await widgetTester.pumpWidget(MaterialApp(
          home: DoggoScreen(
        doggoService: mockDoggoService,
      )));
      await widgetTester.pumpAndSettle();

      // Perform tests
      // -------------------------------
      // | Scaffold
      // -------------------------------
      expect(find.widgetWithText(AppBar, "Doggo diversity display app ^-^"),
          findsOneWidget);
      // Note to self.. how to test for widget colors and such.

      // -------------------------------
      // | Doggo list button
      // -------------------------------
      expect(
          find.widgetWithText(ElevatedButton, "Get List of Doggo Diversity!"),
          findsOneWidget);
    });

    testWidgets('displays list of doggo breeds when request button pressed',
        (widgetTester) async {
      // Set up the services and environment resources needed for the widget being tested
      MockDoggoService mockDoggoService = MockDoggoService();

      // Init the widget
      await widgetTester.pumpWidget(MaterialApp(
          home: DoggoScreen(
        doggoService: mockDoggoService,
      )));
      await widgetTester.pumpAndSettle();

      // Perform tests

      // ----------------------------------------------------------------------
      // | Gather data that expresses the state change we expect
      // ----------------------------------------------------------------------
      List<DoggoBreed> mockDogBreeds =
          mockDoggoService.getDoggoBreedsSync().data!;

      // ----------------------------------------------------------------------
      // | Expect list not being displayed before button is pressed
      // |   nor the progress indicator
      // ----------------------------------------------------------------------

      for (DoggoBreed mockDogBreed in mockDogBreeds) {
        expect(find.widgetWithText(ListTile, mockDogBreed.name), findsNothing);
      }
      expect(find.byType(CircularProgressIndicator), findsNothing);

      // Press button
      await widgetTester.tap(
          find.widgetWithText(ElevatedButton, "Get List of Doggo Diversity!"));
      await widgetTester.pump(const Duration(milliseconds: 100));

      // ----------------------------------------------------------------------
      // | Expect progress indicator to be displayed immediately after b.press
      // ----------------------------------------------------------------------
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await widgetTester.pumpAndSettle();

      // ----------------------------------------------------------------------
      // | Expect list to be displayed after button press
      // |   and progress indicator to be gone
      // ----------------------------------------------------------------------
      expect(find.byType(CircularProgressIndicator), findsNothing);

      for (DoggoBreed mockDogBreed in mockDogBreeds) {
        expect(
            find.widgetWithText(ListTile, mockDogBreed.name), findsOneWidget);
      }
    });
  });
}
