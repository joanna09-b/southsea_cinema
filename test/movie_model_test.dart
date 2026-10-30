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
    test('fromJson builds aMovie with every field', (){
      final Map<String, dynamic> json = <String, dynamic>{
       'id': 'test-film',
        'title': 'Test Film',
        'ageRating': '12A',
        'description': 'A test description.',
        'date': 'Sunday 4 Oct 2026',
        'time': '15:00',
        'price': 9.99,
        'imagePath': 'assets/images/test.jpg',
      };
      final Movie movie = Movie.fromJson(json);

      expect(movie.id, 'test-film');
      expect(movie.title, 'Test Film');
      expect(movie.ageRating, '12A');
      expect(movie.description, 'A test description.');
      expect(movie.date, 'Sunday 4 Oct 2026');
      expect(movie.time, '15:00');
      expect(movie.price, 9.99);
      expect(movie.imagePath, 'assets/images/test.jpg');
      expect(movie.toJson(), json);
      
    });

    test('fromJson converts a whole-number price to a double', () {
      final Map<String, dynamic> json = <String, dynamic>{
        'id': 'whole',
        'title': 'Whole Price',
        'ageRating': 'U',
        'description': 'Whole number price.',
        'date': 'Monday 5 Oct 2026',
        'time': '18:00',
        'price': 8,
        'imagePath': 'assets/images/whole.jpg',
      };
      final Movie movie = Movie.fromJson(json);

      expect(movie.price, isA<double>());
      expect(movie.price, 8.0);
    });
  });
}
