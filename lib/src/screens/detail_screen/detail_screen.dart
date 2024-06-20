import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_dovie/src/screens/detail_screen/widget/tabbar_widget.dart';
import '../../data/video_service.dart';
import '../../domains/models/previews_model.dart';
import '../../global/const/colors.dart';
import '../../presentation/riverpod/favorite_provider.dart';
import '../../widgets/back_save_buttons_widgets.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/logo_widget.dart';
import '../video_screen/full_screen_video_player.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final List<Results> data;
  final int index;
  const DetailScreen({
    super.key,
    required this.data,
    required this.index,
  });
  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final myData = widget.data[widget.index];
    final favoriteMoviesNotifier = ref.watch(favoriteMoviesProvider.notifier);
    final isFavorite =
        ref.watch(favoriteMoviesProvider).any((movie) => movie.id == myData.id);

    final String posterPath = myData.posterPath ?? '';

    return Scaffold(
        body: Stack(children: [
          Positioned.fill(
            child: BackGroundImageWidget(
              image: posterPath.isNotEmpty
                  ? NetworkImage("https://image.tmdb.org/t/p/w500$posterPath")
                  : AssetImage('assets/images/placeholder.png')
                      as ImageProvider,
              child: Center(),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.7),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackAndSaveButtonWidgets(
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: ConstantColor.whiteColor,
                          ),
                        ),
                        LogoWidget(),
                        BackAndSaveButtonWidgets(
                          child: Icon(
                            Icons.favorite,
                            color: isFavorite
                                ? ConstantColor.buttonColorsTwo
                                : ConstantColor.whiteColor,
                          ),
                          onTap: () {
                            favoriteMoviesNotifier.toggleFavorite(
                                myData.id!,
                                myData.title!,
                                myData.posterPath!,
                                myData.originalLanguage!,
                                myData.overview!,
                                myData.voteaverage!,
                                myData.releaseDate!);
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 182,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ContainerWidget(data: widget.data, index: widget.index),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 54,
                              height: 24,
                              decoration: BoxDecoration(
                                  color: ConstantColor.containerColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset("assets/svg/star.svg"),
                                  Text(
                                    myData.voteaverage?.toStringAsFixed(1) ??
                                        'N/A',
                                    maxLines: 4,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                      textStyle: TextStyle(
                                          color: ConstantColor.orangeColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: 184,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6),
                                child: Text(
                                  myData.title ?? 'Unknown',
                                  maxLines: 4,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.plusJakartaSans(
                                    textStyle: TextStyle(
                                        color: ConstantColor.whiteColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                        child: DetailTabbarWidget(widget.data, widget.index)),
                  ],
                ),
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ConstantColor.buttonColorsOne,
            onPressed: () async {
              final String? videoId = await fetchVideoData(myData.id!);
              if (videoId != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FullScreenVideoPlayer(
                      videoId: videoId,
                      movie: Results(
                        id: myData.id,
                        title: myData.title,
                        posterPath: myData.posterPath,
                        overview: myData.overview,
                        voteaverage: myData.voteaverage,
                      ),
                    ),
                  ),
                );
              }
            },
            child: Icon(
              Icons.play_arrow,
              color: ConstantColor.buttonColorsTwo,
              size: 32,
            )));
  }
}
