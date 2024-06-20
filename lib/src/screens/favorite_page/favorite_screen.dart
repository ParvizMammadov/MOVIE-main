import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_dovie/src/screens/detail_screen/detail_screen.dart';
import 'package:movie_dovie/src/widgets/background_image_widget.dart';
import '../../global/const/colors.dart';
import '../../presentation/riverpod/favorite_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMovies = ref.watch(favoriteMoviesProvider);
    final favoriteMoviesNotifier = ref.watch(favoriteMoviesProvider.notifier);

    return BackGroundImageWidget(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () {
            favoriteMoviesNotifier.clearFavorites();
          },
          child: Icon(
            Icons.delete_forever,
            color: ConstantColor.whiteColor,
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.rh),
            child: favoriteMovies.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        AppLocalizations.of(context)!.nofavoritesyet.toString(),
                        style: TextStyle(color: ConstantColor.whiteColor),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: favoriteMovies.length,
                    itemBuilder: (context, index) {
                      final movie = favoriteMovies[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () {
                            Flexify.go(DetailScreen(
                                data: favoriteMovies, index: index));
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
                              favoriteMoviesNotifier.removeFavorite(movie.id!);
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
