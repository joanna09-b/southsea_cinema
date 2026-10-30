import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

class MovieRepository {
  List<Movie>? _cachedMovies;

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
  
  List<Movie> getMovies() {
    final List<Movie>? cachedMovies = _cachedMovies;
    if (cachedMovies != null) {
      return cachedMovies;
    }

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
