import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/cinema_button.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${movie.title} (${movie.ageRating})',
              style: const TextStyle(
                color: cinemaBrand,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  movie.imagePath,
                  width: 159,
                  height: 225,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(
                    movie.description,
                    style: const TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'BOOK TICKETS',
              style: TextStyle(color: cinemaFontWhite, fontSize: 18),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${movie.date}  ${movie.time}',
                    style:
                        const TextStyle(color: cinemaFontWhite, fontSize: 18),
                  ),
                ),
                CinemaButton(
                  label: 'Book Now',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieListing(movie: movie),
                      ),
                    );
                  },
                  
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
