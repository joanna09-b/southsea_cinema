import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      Movie(
        id: 'MIF',
        title: 'Mission: Impossible - Fallout',
        description:
            'Ethan Hunt and his IMF team race against time to recover stolen plutonium cores after a botched mission',
        ageRating: 'PG-13',
        date: 'Sunday 16th November 2026',
        time: '19:30',
        imagePath: 'assets/images/MIF.jpeg',
        price: 12.99,
      ),
      Movie(
        id: 'rio',
        title: 'Rio',
        description:
            'Blu, a domesticated macaw from small-town Minnesota, takes off on an adventure to Rio de Janeiro with the bird of his dreams',
        ageRating: 'G',
        date: 'Saturday 15th November 2026',
        time: '18:00',
        imagePath: 'assets/images/rio.jpeg',
        price: 9.99,
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }
}