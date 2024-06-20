import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'MOVIE-DOVIE',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: const Color(0xFFE5B8F4),
        shadows: [
          Shadow(
            offset: const Offset(2, 2),
            blurRadius: 3,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}
