import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

const Movie testMovie = Movie(
  id: 'test-one',
  title: 'Test Movie',
  ageRating: 'PG',
  imagePath: 'assets/images/test1.jpg',
  description: 'A test movie for unit testing.',
  date: 'Sunday 4 Oct 2026',
  time: '15:00',
  price: 10.0,
);

const Movie testMovie2 = Movie(
  id: 'test-two',
  title: 'Test Movie 2',
  ageRating: '12A',
  imagePath: 'assets/images/test2.jpg',
  description: 'Second test movie.',
  date: 'Sunday 4 Oct 2026',
  time: '17:00',
  price: 12.0,
);

const Movie testMovie3 = Movie(
  id: 'test-three',
  title: 'Test Movie 3',
  ageRating: 'PG',
  imagePath: 'assets/images/test3.jpg',
  description: 'Third test movie.',
  date: 'Sunday 4 Oct 2026',
  time: '19:00',
  price: 15.0,
);

void main() {
  setUp(() async {
    BasketRepository.instance.clear();

    sqfliteFfiInit();

    final Database database = await databaseFactoryFfiNoIsolate.openDatabase(
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

  group('BasketView tests', () {
    testWidgets('shows an empty message when the basket is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      expect(find.text('Your basket is empty'), findsOneWidget);
      expect(find.text('BUY TICKETS'), findsNothing);
    });

    testWidgets('shows order details, service charge and total due', (
      WidgetTester tester,
    ) async {
      BasketRepository.instance.addItem(
        const BasketItem(movie: testMovie, quantity: 2),
      );

      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      expect(find.text('MY ORDER'), findsOneWidget);
      expect(find.text('2 Tickets'), findsOneWidget);
      expect(find.textContaining('Test Movie'), findsOneWidget);
      expect(find.text('£20.00'), findsOneWidget);
      expect(find.text('£2.00'), findsOneWidget);
      expect(find.text('£22.00'), findsOneWidget);
      expect(find.text('UPDATE ORDER'), findsOneWidget);
      expect(find.text('BUY TICKETS'), findsOneWidget);
    });

    testWidgets('removes an item when the delete button is pressed', (
      WidgetTester tester,
    ) async {
      BasketRepository.instance.addItem(
        const BasketItem(movie: testMovie, quantity: 2),
      );

      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      await tester.tap(find.byIcon(Icons.delete));
      await tester.pump();

      expect(find.text('Your basket is empty'), findsOneWidget);
      expect(BasketRepository.instance.getItems(), isEmpty);
    });

    testWidgets('buying tickets clears the basket and shows a confirmation', (
      WidgetTester tester,
    ) async {
      BasketRepository.instance.addItem(
        const BasketItem(movie: testMovie, quantity: 1),
      );

      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      await tester.tap(find.text('BUY TICKETS'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Thanks, your tickets are booked'),
          findsOneWidget);
      expect(BasketRepository.instance.getItems(), isEmpty);
    });
    testWidgets('removes the middle item from three different movies', (
      WidgetTester tester,
    ) async {
      BasketRepository.instance.addItem(
        const BasketItem(movie: testMovie, quantity: 1),
      );

      BasketRepository.instance.addItem(
        const BasketItem(movie: testMovie2, quantity: 1),
      );

      BasketRepository.instance.addItem(
        const BasketItem(movie: testMovie3, quantity: 1),
      );

      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      // Check that all three movies appear.
      expect(find.textContaining('Test Movie,'), findsOneWidget);
      expect(find.textContaining('Test Movie 2,'), findsOneWidget);
      expect(find.textContaining('Test Movie 3,'), findsOneWidget);

      // Delete the second movie.
      await tester.tap(
        find.byKey(const Key('delete-button-1')),
      );

      await tester.pumpAndSettle();

    // Check that only the first and third movies remain.
      expect(find.textContaining('Test Movie 2,'), findsNothing);
      expect(find.textContaining('Test Movie,'), findsOneWidget);
      expect(find.textContaining('Test Movie 3,'), findsOneWidget);

      expect(BasketRepository.instance.getItems(), hasLength(2));
    });
  });
}
