import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/booking.dart';

void main() {
  const Booking booking = Booking(
    bookingNumber: 1004,
    summary: '2 x Rio',
    total: 21.98,
    date: '01/11/2026 09:05',
  );

  group('Booking tests', () {
    test('a new booking has no id and converts to a map', () {
      expect(booking.id, isNull);
      expect(booking.toMap(), <String, Object?>{
        'booking_number': 1004,
        'summary': '2 x Rio',
        'total': 21.98,
        'date': '01/11/2026 09:05',
      });
    });

    test('a database map converts back into a booking', () {
      final Map<String, Object?> row = <String, Object?>{
        'id': 7,
        'booking_number': 1010,
        'summary': '1 x Rio',
        'total': 11.99,
        'date': '02/11/2026 10:20',
      };

      final Booking restored = Booking.fromMap(row);

      expect(restored.id, 7);
      expect(restored.bookingNumber, 1010);
      expect(restored.summary, '1 x Rio');
      expect(restored.total, 11.99);
      expect(restored.date, '02/11/2026 10:20');
      expect(restored.toMap(), row);
    });

    test('a whole-number total from SQLite becomes a double', () {
      final Map<String, Object?> row = booking.toMap();
      row['total'] = 6;

      final Booking restored = Booking.fromMap(row);

      expect(restored.total, 6.0);
      expect(restored.total, isA<double>());
    });
  });
}