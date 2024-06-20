import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_dovie/src/screens/detail_screen/detail_screen.dart';

import '../../../domains/models/previews_model.dart';
import '../../../widgets/card_widget.dart';

class GridviewWidget extends ConsumerWidget {
  final FutureProvider<PreviewsModel?> provider;

  const GridviewWidget(this.provider, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(provider.future);
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!.results;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 1.5,
                mainAxisSpacing: 18.8,
                crossAxisSpacing: 13),
            shrinkWrap: true,
            itemCount: data!.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Flexify.go(
                      DetailScreen(
                        index: index,
                        data: data,
                      ),
                      animation: FlexifyRouteAnimations.slideFromBottom,
                      animationDuration: const Duration(milliseconds: 400));
                },
                child: ContainerWidget(data: data, index: index),
              );
            },
          );
        } else {
          return const Center(child: Text('No Data'));
        }
      },
    );
  }
}
