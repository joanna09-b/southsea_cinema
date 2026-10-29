import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

const Movie testMovie1 = Movie(
  id: 'test-one',
  title: 'Test Movie',
  ageRating: 'PG',
  imagePath: 'assets/images/test1.jpg',
  description: 'A test movie for unit testing.',
  date: '2024-01-01',
  time: '12:00',
  price: 10.0,
);

const Movie testMovie2 = Movie(
  id: 'test-two',
  title: 'Another Test Movie',
  ageRating: '12A',
  imagePath: 'assets/images/test2.jpg',
  description: 'Another test movie for unit testing.',
  date: '2024-01-02',
  time: '14:00',
  price: 12.0,
);

void main() {
  setUp(() {
    BasketRepository.instance.clear();
  });

  group('BasketRepository tests',() {
    test('starts empty with zero totals', () {
      final BasketRepository basket = BasketRepository.instance;

      expect(basket.getItems(), isEmpty);
      expect(basket.getTotalTickets(), 0);
      expect(basket.getTotal(), 0.0);
    });
    test('adds items and calculates totals', () {
      final BasketRepository basket = BasketRepository.instance;

      basket.addItem(const BasketItem(movie: testMovie1, quantity: 2));
      basket.addItem(const BasketItem(movie: testMovie2, quantity: 1));

      expect(basket.getItems().length, 2);
      expect(basket.getTotalTickets(), 3);
      expect(basket.getTotal(), 32.0); // (2 * 10.0) + (1 * 12.0)
    }
    );

    test('removes an item by index', () {
      final BasketRepository basket = BasketRepository.instance;

      basket.addItem(const BasketItem(movie: testMovie1, quantity: 2));
      basket.addItem(const BasketItem(movie: testMovie2, quantity: 1));

      basket.removeItem(0);

      expect(basket.getItems().length, 1);
      expect(basket.getItems().first.movie.id, 'test-two');
      expect(basket.getTotal(), 12.0); // (1 * 12.0)
    });
    test('ignore an invalid index when removing an item', () {
      final BasketRepository basket = BasketRepository.instance;

      basket.addItem(const BasketItem(movie: testMovie1, quantity: 1));

      basket.removeItem(5); // Invalid index

      expect(basket.getItems().length, 1);
    });

    test('clear epties the basket', () {
      final BasketRepository basket = BasketRepository.instance;

      basket.addItem(const BasketItem(movie: testMovie1, quantity: 3));
     
      basket.clear();

      expect(basket.getItems(), isEmpty);
      expect(basket.getTotal(), 0.0);
    });

    test('the list from getItems cannot be modified', () {
      final BasketRepository basket = BasketRepository.instance;

      expect(
        () => basket.getItems().add(const BasketItem(movie: testMovie1, quantity: 1)),
        throwsUnsupportedError,
      );

    });
  });
}