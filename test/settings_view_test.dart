import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  group('SettingsView tests', () {
    testWidgets('displays the form fields, switch and save button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsView()));

      expect(find.text('Customer Profile'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(Switch), findsOneWidget);
      expect(find.text('Save Settings'), findsOneWidget);
    });

    testWidgets('toggling the switch and saving shows a confirmation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsView()));

      await tester.enterText(
        find.widgetWithText(TextField, 'Full name'),
        'Alex Smith',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Email address'),
        'alex@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextField, 'Phone number'),
        '07000 000000',
      );

      final Finder switchFinder = find.byType(Switch);
      expect(tester.widget<Switch>(switchFinder).value, isFalse);
      await tester.tap(switchFinder);
      await tester.pump();
      expect(tester.widget<Switch>(switchFinder).value, isTrue);

      await tester.tap(find.text('Save Settings'));
      await tester.pump();

      expect(find.text('Settings saved for Alex Smith'), findsOneWidget);
    });
  });
}