import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie>? _cachedMovies;

  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }

    return const [
      Movie(
        id: '1',
        title: 'Mission: Impossible - Fallout',
        ageRating: 'PG-13',
        description:
            'Ethan Hunt and his IMF team race against time to recover stolen plutonium cores after a botched mission',
        date: '2024-07-12',
        time: '19:30',
        price: 9.99,
        imagePath: 'assets/images/MIF.jpeg',
      ),
      Movie(
        id: '2',
        title: 'Rio',
        ageRating: 'G',
        description:
            'Blu, a domesticated macaw from small-town Minnesota, takes off on an adventure to Rio de Janeiro with the bird of his dreams',
        date: '2024-07-15',
        time: '18:00',
        price: 9.99,
        imagePath: 'assets/images/rio.jpeg',
      ),
    ];
  }

  Movie? getMovieById(String id) {
    for (final Movie movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }
    return null;
  }

  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async {
    final String jsonString = await rootBundle.loadString(assetPath);
    final dynamic decodedData = jsonDecode(jsonString);
    final List<dynamic> jsonList = decodedData as List<dynamic>;
    final List<Movie> loadedMovies = [];

    for (final dynamic item in jsonList) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      final Movie movie = Movie.fromJson(itemMap);
      loadedMovies.add(movie);
    }

    _cachedMovies = loadedMovies;
    return loadedMovies;
  }
}