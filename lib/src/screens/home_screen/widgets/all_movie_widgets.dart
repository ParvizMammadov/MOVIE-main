import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_dovie/src/presentation/riverpod/api_providers.dart';
import 'package:movie_dovie/src/widgets/card_widget.dart';

import '../../detail_screen/detail_screen.dart';

class AllMoviesWidget extends ConsumerWidget {
  const AllMoviesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(apiProviderOfDay.future);
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
          return SizedBox(
            height: 191.rh,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: 20.rw, top: 10.rh),
                  child: InkWell(
                    onTap: () {
                      Flexify.go(
                          DetailScreen(
                            index: index,
                            data: data,
                          ),
                          animation: FlexifyRouteAnimations.slideFromBottom,
                          animationDuration: const Duration(milliseconds: 400));
                    },
                    child: ContainerWidget(
                      data: data,
                      index: index,
                      width: 111.25.rw,
                      height: 191.52.rh,
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No Data'));
        }
      },
    );
  }
}
