import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: colorScheme.surface,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: colorScheme.surface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      appTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: colorScheme.primary),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const DrawerTile(title: 'Home', route: '/'),
            const DrawerTile(title: 'Basket', route: '/basket'),
            const DrawerTile(title: 'Settings', route: '/settings'),
            const DrawerTile(title: 'Bookings', route: '/bookings'),
            //const DrawerTile(title: 'Movie Listing', route: '/listing'),
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final String? route;

  const DrawerTile({super.key, required this.title, this.route});

  @override
  Widget build(BuildContext context) {
    final TextStyle? tileStyle = Theme.of(context).textTheme.bodyLarge;

    return ListTile(
      title: Text(title, style: tileStyle),
      onTap: () {
        Navigator.pop(context);
        if (route != null) {
          Navigator.pushNamed(context, route!);
        }
      },
    );
  }
}
