import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/booking.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class BookingsView extends StatefulWidget {
  const BookingsView({super.key});

  @override
  State<BookingsView> createState() {
    return _BookingsViewState();
  }
}

class _BookingsViewState extends State<BookingsView> {
  late Future<List<Booking>> _bookings;

  @override
  void initState() {
    super.initState();
    _bookings = CinemaDatabase.instance.getAllBookings();
  }

  Widget _buildBookingsList(List<Booking> bookings) {
    if (bookings.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            'No previous bookings found.',
            style: TextStyle(color: cinemaFontWhite, fontSize: 16),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final Booking booking = bookings[index];

        return Card(
          color: cinemaSurface,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(
              'Booking #${booking.bookingNumber}',
              style: const TextStyle(
                color: cinemaBrand,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${booking.summary}\n'
              'Date: ${booking.date}',
              style: const TextStyle(color: cinemaFontWhite),
            ),
            trailing: Text(
              '£${booking.total.toStringAsFixed(2)}',
              style: const TextStyle(
                color: cinemaFontWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      drawer: const NavDrawer(),
      body: FutureBuilder<List<Booking>>(
        future: _bookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Could not load bookings.',
                style: TextStyle(color: cinemaFontWhite),
              ),
            );
          }

          final List<Booking> bookings = snapshot.data ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: _buildBookingsList(bookings),
          );
        },
      ),
    );
  }
}
