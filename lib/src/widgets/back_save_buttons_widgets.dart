import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import '../global/const/colors.dart';

class BackAndSaveButtonWidgets extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const BackAndSaveButtonWidgets({
    super.key,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () {
            Flexify.back();
          },
      child: Container(
          width: 40.rw,
          height: 40.rh,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: ConstantColor.buttonColorsOne,
              borderRadius: BorderRadius.circular(15)),
          child: child),
    );
  }
}
