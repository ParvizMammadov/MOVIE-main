import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_dovie/src/screens/detail_screen/detail_screen.dart';
import 'package:movie_dovie/src/widgets/background_image_widget.dart';
import '../../global/const/colors.dart';
import '../../presentation/riverpod/watched_video_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WatchedVideosScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchedVideos = ref.watch(watchedVideosProvider);
    final watchedVideosNot = ref.watch(watchedVideosProvider.notifier);
    return BackGroundImageWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: watchedVideos.isEmpty
            ? Center(
                child: Text(
                AppLocalizations.of(context)!.novideoswatchedyet.toString(),
                style: TextStyle(color: ConstantColor.whiteColor),
              ))
            : Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: watchedVideos.length,
                  itemBuilder: (context, index) {
                    final movie = watchedVideos[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Flexify.go(
                              DetailScreen(data: watchedVideos, index: index));
                        },
                        leading: Container(
                          width: 100,
                          height: 145.92,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.fitWidth,
                              alignment: Alignment.topCenter,
                              image: NetworkImage(
                                "https://image.tmdb.org/t/p/w500${movie.posterPath}",
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          movie.title ?? 'Unknown',
                          style: TextStyle(color: ConstantColor.whiteColor),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete,
                              color: ConstantColor.whiteColor),
                          onPressed: () {
                            watchedVideosNot.removeFavorite(movie.id!);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
