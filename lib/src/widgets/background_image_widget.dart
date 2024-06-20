import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';

class BackGroundImageWidget extends StatelessWidget {
  final Widget child;
  final ImageProvider<Object>? image;
  const BackGroundImageWidget({
    super.key,
    required this.child,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 812.rh,
        width: 375.rw,
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: image ??
              AssetImage(
                'assets/images/Sky.png',
              ),
        )),
        child: child);
  }
}
