import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie> getMovies() {
    return  [
      Movie(
        id: '1',
        title: 'Mission: Impossible - Fallout',
        description:
            '"Ethan Hunt and his IMF team race against time to recover stolen plutonium cores after a botched mission"',
        imagePath: 'images/MIF.jpeg',
      ),
      Movie(
        id: '2',
        title: 'Rio',
        description:
            '"Blu, a domesticated macaw from small-town Minnesota, takes off on an adventure to Rio de Janeiro with the bird of his dreams"',
        imagePath: 'images/rio.jpeg',
      ),
    ];
  }
}