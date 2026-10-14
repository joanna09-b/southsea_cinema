import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    test('creates Movie instance with given properties', () {
      const movie = Movie(
        id: 'test-film',
        title: 'Test Film',
        ageRating: '12A',
        imagePath: 'assets/images/test.jpg',
        description: 'A test description.',
        date: 'Sunday 4 Oct 2026',
        time: '15:00',
        price: 8.0,
      );

      expect(movie.id, 'test-film');
      expect(movie.title, 'Test Film');
      expect(movie.ageRating, '12A');
      expect(movie.price, 8.0);
    });

    test('formattedPrice shows two decimals for a whole-pound price', () {
      const movie = Movie(
        id: 'a',
        title: 'A',
        ageRating: 'U',
        imagePath: 'a.jpg',
        description: 'A',
        date: 'Monday',
        time: '10:00',
        price: 8.0,
      );

      expect(movie.formattedPrice, '£8.00');
    });

    test('formattedPrice shows two decimals for a price with pence', () {
      const movie = Movie(
        id: 'b',
        title: 'B',
        ageRating: 'U',
        imagePath: 'b.jpg',
        description: 'B',
        date: 'Monday',
        time: '10:00',
        price: 7.5,
      );

      expect(movie.formattedPrice, '£7.50');
    });
  });
}