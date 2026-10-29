import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';

void main() {
  group('CinemaButton tests', () {
    testWidgets('renders its label',(WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CinemaButton(label: 'Book Now', onPressed: () {},),
          ),
        ),
      );

      expect(find.text('Book Now'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (WidgetTester tester) async {
      bool wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CinemaButton(
              label: 'Book Now',
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Book Now'));
      await tester.pump();

      expect(wasPressed, isTrue);
    });
  });
}