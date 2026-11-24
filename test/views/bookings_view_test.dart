import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking.dart';
import 'package:southsea_cinema/views/bookings_view.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUp(() async {
    sqfliteFfiInit();

    final Database database =
        await databaseFactoryFfiNoIsolate.openDatabase(
      inMemoryDatabasePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: CinemaDatabase.instance.createTables,
      ),
    );

    CinemaDatabase.instance.setDatabase(database);
  });

  tearDown(() async {
    await CinemaDatabase.instance.close();
  });

  testWidgets('shows the loading state while bookings are fetched', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: BookingsView()),
    );

    expect(find.text('My Bookings'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows seeded bookings in booking number order', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      await CinemaDatabase.instance.insertBooking(
        const Booking(
          bookingNumber: 1003,
          summary: '2 x Rio',
          total: 21.98,
          date: '18/10/2026 14:30',
        ),
      );
      await CinemaDatabase.instance.insertBooking(
        const Booking(
          bookingNumber: 1002,
          summary: '1 x Mission: Impossible - Fallout',
          total: 11.99,
          date: '02/10/2026 19:10',
        ),
      );
      await CinemaDatabase.instance.insertBooking(
        const Booking(
          bookingNumber: 1001,
          summary: '3 x Rio',
          total: 31.97,
          date: '11/09/2026 13:02',
        ),
      );
    });

    await tester.pumpWidget(
      const MaterialApp(home: BookingsView()),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Bookings'), findsOneWidget);
    expect(find.text('Booking #1003'), findsOneWidget);
    expect(find.textContaining('2 x Rio'), findsOneWidget);
    expect(find.textContaining('18/10/2026 14:30'), findsOneWidget);
    expect(find.text('£21.98'), findsOneWidget);
    expect(find.text('Booking #1002'), findsOneWidget);
    expect(
      find.textContaining('1 x Mission: Impossible - Fallout'),
      findsOneWidget,
    );
    expect(find.text('£11.99'), findsOneWidget);
    expect(find.text('Booking #1001'), findsOneWidget);
    expect(find.textContaining('3 x Rio'), findsOneWidget);
    expect(find.text('£31.97'), findsOneWidget);

    final Offset firstBooking = tester.getTopLeft(find.text('Booking #1003'));
    final Offset secondBooking = tester.getTopLeft(find.text('Booking #1002'));
    final Offset thirdBooking = tester.getTopLeft(find.text('Booking #1001'));
    expect(firstBooking.dy, lessThan(secondBooking.dy));
    expect(secondBooking.dy, lessThan(thirdBooking.dy));
  });

  testWidgets('shows the empty message when there are no bookings', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: BookingsView()),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Bookings'), findsOneWidget);
    expect(find.text('No previous bookings found.'), findsOneWidget);
  });

  testWidgets('shows the error state when bookings cannot be loaded', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() async {
      await CinemaDatabase.instance.close();

      final Database database =
          await databaseFactoryFfiNoIsolate.openDatabase(
        inMemoryDatabasePath,
      );
      CinemaDatabase.instance.setDatabase(database);
    });

    await tester.pumpWidget(
      const MaterialApp(home: BookingsView()),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Bookings'), findsOneWidget);
    expect(find.text('Could not load bookings.'), findsOneWidget);
  });
}