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
        children: const [
          Text(
            'INCEPTION (2010) (12A)',
            style: TextStyle(
              color: cinemaFontWhite,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 40),
          Text(
            'Runtime: 148 minutes',
          ),
          SizedBox(height: 27),
          Text(
            'A thief who steals secrets through dreams is given one last job.',
          ),
        ],
      ),
    ),
  );
}

}