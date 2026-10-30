import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
    TestWidgetsFlutterBinding.ensureInitialized();
  group('MovieRepository unit tests', () {
    test('getMovies returns two movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    test('getMovieById returns matching movie when id exists', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('MIF');
      expect(movie, isNotNull);
      expect(movie?.title, 'Mission: Impossible - Fallout');
    });

    test('getMovieById returns null when id does not exist', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('non-existent');

      expect(movie, isNull);
    });

    test('loadMoviesFromAsset reads every film from the JSON file', () async {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = await repository.loadMoviesFromAsset();

      expect(movies.length, 2);
      expect(movies[0].title, 'Mission: Impossible - Fallout');
      expect(movies[1].title, 'Rio');
      expect(repository.getMovies(), movies);

    });
  });
}
