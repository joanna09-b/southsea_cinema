import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() {
    return _MovieListingState();
  }
}

class _MovieListingState extends State<MovieListing> {
  int _ticketQuantity = 0;
  int totalTicket = 0;

  int _ticketOrdered(int quantity) {
    return quantity;
  }

    
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
        color: const Color(0xFF1C1E26),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            const Text(
              'Mission: Impossible - Fallout',
              style: TextStyle(
                color: cinemaFontWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Southsea Cinema Room'),
            const Text('Tuesday 10th October 2026, 18:30 - ends at 21:00'),
            const Text(
              '"Ethan Hunt and his IMF team race against time to recover stolen plutonium cores after a botched mission"',
            ),
            const Text(
              'Please note that discounts / membership benefits will be applied once you have selected your tickets.',
            ),
            const Text('Select Quantites (Up to 5 in total)'),
            const Text(
              'Tickets',
              style: TextStyle(
                color: cinemaFontWhite,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                DropdownMenu<int>(
                  initialSelection: 0,
                  width: 100,
                  textStyle: const TextStyle(color: Color.fromARGB(255, 17, 16, 16)),
                  inputDecorationTheme: const InputDecorationTheme(
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onSelected: (int? value) {
                    if (value != null) {
                      setState(() {
                        _ticketQuantity = value;
                      });
                    }
                  },
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 0, label: '0'),
                    DropdownMenuEntry(value: 1, label: '1'),
                    DropdownMenuEntry(value: 2, label: '2'),
                    DropdownMenuEntry(value: 3, label: '3'),
                    DropdownMenuEntry(value: 4, label: '4'),
                    DropdownMenuEntry(value: 5, label: '5'),
                  ],
                ),
                const SizedBox(width: 14),
                const Text('Adult (£7.50)'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 20),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    totalTicket = _ticketOrdered(_ticketQuantity);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cinemaBrand,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                ),
                child: Text(
                  'ADD TO ORDER \nYou ordered $totalTicket ticket${totalTicket == 1 ? '' : 's'}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}