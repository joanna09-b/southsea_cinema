import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

void main() {
  final List<Movie> movies = MovieRepository().getMovies();

  void useTallScreen(WidgetTester tester) {
    tester.view.physicalSize = const Size(800, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  group('Home page tests', () {
    testWidgets('shows title, movie cards and booking buttons',
        (WidgetTester tester) async {
      useTallScreen(tester);
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.text(appTitle), findsOneWidget);
      expect(find.byType(MovieCard), findsNWidgets(movies.length));
      expect(find.text('Book Now'), findsNWidgets(movies.length));

      for (final Movie movie in movies) {
        expect(
            find.text('${movie.title} (${movie.ageRating})'), findsOneWidget);
      }
    });
  });
}
