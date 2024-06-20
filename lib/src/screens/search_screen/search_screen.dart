import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_dovie/src/global/const/colors.dart';
import 'package:movie_dovie/src/screens/detail_screen/detail_screen.dart';
import '../../data/data_service.dart';
import '../../domains/models/previews_model.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/card_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/logo_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ApiService _apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  PreviewsModel? _searchResults;
  bool _isLoading = false;

  void _searchMovies() async {
    setState(() {
      _isLoading = true;
    });
    final results = await _apiService.searchMovies(query: _controller.text);
    setState(() {
      _searchResults = results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackGroundImageWidget(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 21.rw, vertical: 10.rh),
          child: Column(
            children: [
              const Center(
                child: LogoWidget(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  text: "Search",
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) => _searchMovies(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Something';
                    }

                    return null;
                  },
                ),
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : _searchResults != null
                      ? Expanded(child: _buildSearchResults())
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults?.results?.isEmpty ?? true) {
      return Center(
        child: Text(
          AppLocalizations.of(context)!.notfound.toString(),
          style: GoogleFonts.plusJakartaSans(
            textStyle: TextStyle(
              color: ConstantColor.whiteColor,
              fontWeight: FontWeight.w400,
              fontSize: 20.rt,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 500.rh,
      child: ListView.builder(
        itemCount: _searchResults?.results?.length ?? 0,
        itemBuilder: (context, index) {
          final result = _searchResults?.results?[index];
          if (result == null) return SizedBox();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Flexify.go(DetailScreen(
                        data: _searchResults!.results!, index: index));
                  },
                  child: ContainerWidget(
                    data: _searchResults!.results!,
                    index: index,
                  ),
                ),
                SizedBox(
                  width: 12.rw,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        result.title ?? 'No title',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.plusJakartaSans(
                          textStyle: TextStyle(
                              color: ConstantColor.whiteColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.rt),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
