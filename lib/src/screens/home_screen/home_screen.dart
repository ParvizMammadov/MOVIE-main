import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_dovie/src/global/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_dovie/src/screens/home_screen/widgets/all_movie_widgets.dart';
import 'package:movie_dovie/src/screens/home_screen/widgets/movies_category_widgets.dart';
import 'package:movie_dovie/src/widgets/background_image_widget.dart';
import 'package:movie_dovie/src/widgets/logo_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundImageWidget(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 21.rw, vertical: 10.rh),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: LogoWidget()),
              SizedBox(
                height: 20.rh,
              ),
              Text(
                AppLocalizations.of(context)!.movieday.toString(),
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                      color: ConstantColor.whiteColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 24),
                ),
              ),
              SizedBox(
                height: 20.rh,
              ),
              const AllMoviesWidget(),
              MoviesCategoryWidgets(),
            ],
          ),
        ),
      )),
    );
  }
}
