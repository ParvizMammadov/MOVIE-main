import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_dovie/src/global/const/colors.dart';
import '../../../domains/models/onboarding_model.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({
    super.key,
    required this.models,
  });
  final OnBoardingModel models;
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final size = MediaQuery.of(context).size.height;
    return Container(
      width: 375.rw,
      color: models.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: models.width,
            height: models.height,
            image: AssetImage(
              models.image,
            ),
          ),
          SizedBox(
            height: 25.rh,
          ),
          Text(
            models.title,
            style: GoogleFonts.dmSerifText()
                .copyWith(fontSize: 35, color: ConstantColor.buttonColorsTwo),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10.rh,
          ),
          Text(
            models.subTitle,
            style: GoogleFonts.dmSerifText()
                .copyWith(fontSize: 30, color: ConstantColor.buttonColorsTwo),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
