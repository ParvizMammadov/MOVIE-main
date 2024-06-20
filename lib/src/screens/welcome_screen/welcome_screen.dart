import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import '../../widgets/background_image_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundImageWidget(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Rent your favourite \nmovie ticker now!',
            style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: 24.rt,
                fontWeight: FontWeight.w700),
          ),
          ElevatedButton(
            onPressed: null,
            child: Container(
              alignment: Alignment.center,
              width: 335.rw,
              height: 51.rh,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF810CA8), Color(0xFFE5B8F4)],
                ),
              ),
              child: Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 14.rt,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2D033B),
                ),
              ),
            ),
          ),
          20.verticalSpace,
          Text(
            'login',
            style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: 16.rt,
                fontWeight: FontWeight.w700),
          )
        ],
      )),
    );
  }
}
