import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
    drawer: const NavDrawer(),
    body: Container(
      color: const Color(0xFF1C1E26), // dark background like the example
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: const [
          Text(
            'Mission: Impossible - Fallout',
            style: TextStyle(
              color: cinemaFontWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Southsea Cinema Room',
          ),
          Text(
            'Tuesday 10th October 2026, 18:30 - ends at 21:00',
          ),
          Text(
            '"Ethan Hunt and his IMF team race against time to recover stolen plutonium cores after a botched mission"',
          ),
          Text('Please note that discounts / membership benefits will be applied once you have selected your tickets.'),
          Text('Select Quantites (Up to 5 in total)'),
          
          Text(
            'Tickets',
            style: TextStyle(
              color: cinemaFontWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          
          
        ],
      ),
    ),
  );
}

}