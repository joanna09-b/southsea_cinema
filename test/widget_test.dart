import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:flutter/services.dart';

void main() {
  setUp(() {
    BasketRepository.instance.clear();
    rootBundle.clear();
  });

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
      await tester.pumpAndSettle();

      expect(find.text(appTitle), findsOneWidget);
      expect(find.byType(MovieCard), findsNWidgets(movies.length));
      expect(find.text('Book Now'), findsNWidgets(movies.length));

      for (final Movie movie in movies) {
        expect(
            find.text('${movie.title} (${movie.ageRating})'), findsOneWidget);
      }
    });
  });
  group('Booking tests', () {
    Future<void> openFirstListing(WidgetTester tester) async {
      useTallScreen(tester);
      await tester.pumpWidget(const SouthseaCinemaApp());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Book Now').first);
      await tester.pumpAndSettle();
    }

    testWidgets('Book Now opens the listing for that film',
        (WidgetTester tester) async {
      await openFirstListing(tester);

      expect(find.byType(MovieListing), findsOneWidget);
      expect(find.text('${movies[0].title} (${movies[0].ageRating})'),
          findsOneWidget);
      expect(find.textContaining(movies[0].date), findsOneWidget);
    });

    testWidgets('Add to order shows how many tickets were ordered',
        (WidgetTester tester) async {
      await openFirstListing(tester);

      expect(find.textContaining('You ordered 0 tickets'), findsOneWidget);

      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('2').last);
      await tester.pumpAndSettle();

      await tester.tap(find.textContaining('ADD TO ORDER'));
      await tester.pump();

      expect(find.textContaining('You ordered 2 tickets'), findsOneWidget);
    });
  });
}
