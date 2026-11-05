import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });
  group('SettingsView tests', () {
    testWidgets('displays the form fields, switch and save button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsView()));
      await tester.pumpAndSettle();

      expect(find.text('Customer Profile'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(Switch), findsOneWidget);
      expect(find.text('Save Settings'), findsOneWidget);
    });

    testWidgets('toggling the switch and saving shows a confirmation', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: SettingsView()));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextField).at(0),
        'Alex Smith',
      );
      await tester.enterText(
        find.byType(TextField).at(1),
        'alex@example.com',
      );
      await tester.enterText(
        find.byType(TextField).at(2),
        '07000 000000',
      );

      final Finder switchFinder = find.byType(Switch);
      expect(tester.widget<Switch>(switchFinder).value, isFalse);

      await tester.tap(switchFinder);
      await tester.pumpAndSettle();
      expect(tester.widget<Switch>(switchFinder).value, isTrue);

      await tester.tap(find.text('Save Settings'));
      await tester.pumpAndSettle();

      expect(find.text('Settings saved for Alex Smith'), findsOneWidget);

      final SharedPreferencesAsync prefs = SharedPreferencesAsync();

      expect(await prefs.getString(prefName), 'Alex Smith');
      expect(await prefs.getString(prefEmail), 'alex@example.com');
      expect(await prefs.getString(prefPhone), '07000 000000');
      expect(await prefs.getBool(prefNewsletter), isTrue);

      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pumpWidget(const MaterialApp(home: SettingsView()));
      await tester.pumpAndSettle();

      expect(find.text('Alex Smith'), findsOneWidget);
      expect(find.text('alex@example.com'), findsOneWidget);
      expect(find.text('07000 000000'), findsOneWidget);

      final Switch reopenedSwitch = tester.widget<Switch>(find.byType(Switch));
      expect(reopenedSwitch.value, isTrue);
    });

    testWidgets('loads previously saved settings when opened', (
      WidgetTester tester,
    ) async {
      SharedPreferencesAsyncPlatform.instance =
          InMemorySharedPreferencesAsync.withData(<String, Object>{
        prefName: 'Alex Smith',
        prefEmail: 'alex@example.com',
        prefPhone: '07000 000000',
        prefNewsletter: true,
      });

      await tester.pumpWidget(const MaterialApp(home: SettingsView()));
      await tester.pumpAndSettle();

      expect(find.text('Alex Smith'), findsOneWidget);
      expect(find.text('alex@example.com'), findsOneWidget);
      expect(find.text('07000 000000'), findsOneWidget);

      final Switch switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isTrue);
    });
  });
}
