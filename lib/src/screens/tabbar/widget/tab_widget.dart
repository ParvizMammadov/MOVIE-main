import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../global/const/colors.dart';

class TabWidget extends StatelessWidget {
  final String text;
  final bool isActive;
  const TabWidget({
    super.key,
    required this.text,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: text == "profile"
          ? Icon(
              Icons.person, size: 32.rs,
              fill: 1,
              // ignore: deprecated_member_use
              color: isActive
                  ? ConstantColor.buttonColorsOne
                  : ConstantColor.greyColor,
            )
          : text == "notification"
              ? Icon(
                  Icons.manage_history_rounded, size: 28.rs,
                  fill: 1,
                  // ignore: deprecated_member_use
                  color: isActive
                      ? ConstantColor.buttonColorsOne
                      : ConstantColor.greyColor,
                )
              : SvgPicture.asset(
                  "assets/svg/$text.svg",
                  width: 23.rs,
                  height: 23.rs,
                  // ignore: deprecated_member_use
                  color: isActive
                      ? ConstantColor.buttonColorsOne
                      : ConstantColor.greyColor,
                ),
    );
  }
}
