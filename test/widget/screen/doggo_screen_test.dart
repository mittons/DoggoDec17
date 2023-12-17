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
          (await mockDoggoService.getDoggoBreeds()).data!;

      // ----------------------------------------------------------------------
      // | Expect list not being displayed before button is pressed
      // ----------------------------------------------------------------------

      for (DoggoBreed mockDogBreed in mockDogBreeds) {
        expect(find.widgetWithText(ListTile, mockDogBreed.name), findsNothing);
      }

      // Press button
      await widgetTester.tap(
          find.widgetWithText(ElevatedButton, "Get List of Doggo Diversity!"));
      await widgetTester.pumpAndSettle();

      // ----------------------------------------------------------------------
      // | Expect list to be displayed after button press
      // ----------------------------------------------------------------------

      for (DoggoBreed mockDogBreed in mockDogBreeds) {
        expect(
            find.widgetWithText(ListTile, mockDogBreed.name), findsOneWidget);
      }
    });
  });
}
