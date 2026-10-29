import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';

class CinemaButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CinemaButton({
    super.key, 
    required this.label, 
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: cinemaBrand,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),),
      onPressed: onPressed,
      child: Text(label, textAlign: TextAlign.center,),
    );

  }
}