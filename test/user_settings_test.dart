import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main() {
  group('UserSettings tests', () {
    test('default settings are empty and newsletter is off', () {
      const UserSettings settings = UserSettings();

      expect(settings.name, isEmpty);
      expect(settings.email, isEmpty);
      expect(settings.phoneNumber, isEmpty);
      expect(settings.receiveNewsletters, isFalse);
    });

    test('stores the values passed to the constructor', () {
      const UserSettings settings = UserSettings(
        name: 'Alex Smith',
        email: 'alex@example.com',
        phoneNumber: '07000 000000',
        receiveNewsletters: true,
      );

      expect(settings.name, 'Alex Smith');
      expect(settings.email, 'alex@example.com');
      expect(settings.phoneNumber, '07000 000000');
      expect(settings.receiveNewsletters, isTrue);
    });
  });
}