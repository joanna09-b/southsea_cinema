import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

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

void main() {
  setUp(() {
    BasketRepository.instance.clear();
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
      await tester.pump();

      expect(find.text('Thanks, your tickets are booked'), findsOneWidget);
      expect(BasketRepository.instance.getItems(), isEmpty);
    });
  });
}