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
    testWidgets('displays empty state when basket is empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      expect(find.text('Your basket is empty.'), findsOneWidget);
      expect(find.text('Checkout'), findsNothing);
    });

    testWidgets('shows items and removes one when delete is pressed', (
      WidgetTester tester,
    ) async {
      BasketRepository.instance.addItem(
        const BasketItem(movie: testMovie, quantity: 2),
      );

      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      expect(find.text('Your basket'), findsOneWidget);
      expect(find.text('2 x Test Movie'), findsOneWidget);
      expect(find.textContaining('£20.00'), findsNWidgets(2));
      expect(find.text('Checkout'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.delete_outline));
      await tester.pump();

      expect(find.text('Your basket is empty.'), findsOneWidget);
      expect(BasketRepository.instance.getItems(), isEmpty);
    });
    testWidgets('checkout clears the basket and shows a confirmation message', (WidgetTester tester) async {
      BasketRepository.instance.addItem(
        const BasketItem(movie: testMovie, quantity: 1),
      );

      await tester.pumpWidget(const MaterialApp(home: BasketView()));

      await tester.tap(find.text('Checkout'));
      await tester.pump();

      expect(find.text('Thank you for your order!'), findsOneWidget);
      expect(BasketRepository.instance.getItems(), isEmpty);
    });
  });
}