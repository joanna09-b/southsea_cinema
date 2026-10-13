import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return [
      Movie(
        id: '1',
        title: 'Mission: Impossible - Fallout',
        description:
            '"Ethan Hunt and his IMF team race against time to recover stolen plutonium cores after a botched mission"',
        ageRating: 'PG-13',
        date: '2024-07-12',
        time: '19:30',
        imagePath: 'images/MIF.jpeg',
      ),
      Movie(
        id: '2',
        title: 'Rio',
        description:
            '"Blu, a domesticated macaw from small-town Minnesota, takes off on an adventure to Rio de Janeiro with the bird of his dreams"',
        ageRating: 'G',
        date: '2024-07-15',
        time: '18:00',
        imagePath: 'images/rio.jpeg',
      ),
    ];
  }
}