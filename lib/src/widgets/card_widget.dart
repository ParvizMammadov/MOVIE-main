import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import '../domains/models/previews_model.dart';

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    super.key,
    required this.data,
    required this.index,
    this.width,
    this.height,
  });

  final List<Results> data;
  final int index;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final myData = data[index];
    return Container(
      width: width ?? 100.rw,
      height: height ?? 145.92.rh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: myData.posterPath != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${myData.posterPath!}',
                ),
              )
            : null,
        color:
            myData.posterPath == null ? Colors.grey : null,
      ),
    );
  }
}
