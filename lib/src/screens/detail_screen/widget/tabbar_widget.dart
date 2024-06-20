import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domains/models/previews_model.dart';
import '../../../global/const/colors.dart';
import '../../../presentation/riverpod/tab_notifier.dart';
import '../../../widgets/text_widgets_poppins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailTabbarWidget extends ConsumerStatefulWidget {
  final List<Results> data;
  final int index;
  const DetailTabbarWidget(this.data, this.index, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetailTabbarWidgetState();
}

class _DetailTabbarWidgetState extends ConsumerState<DetailTabbarWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        ref.read(tabProvider.notifier).changeTab(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tabIndex = ref.watch(tabProvider);
    final myData = widget.data[widget.index];

    int initialIndex = (tabIndex >= 0 && tabIndex < 2) ? tabIndex : 0;

    return DefaultTabController(
      initialIndex: initialIndex,
      length: 2,
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: ConstantColor.whiteColor,
            isScrollable: true,
            indicatorPadding:
                EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
            indicatorWeight: 4.0,
            tabs: [
              Tab(
                child: TextButton(
                  onPressed: () {
                    _tabController.animateTo(0);
                  },
                  child: TextWidgetPoppins(
                    text: AppLocalizations.of(context)!.description,
                  ),
                ),
              ),
              Tab(
                child: TextButton(
                  onPressed: () {
                    _tabController.animateTo(1);
                  },
                  child: TextWidgetPoppins(
                    text: AppLocalizations.of(context)!.details,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextWidgetPoppins(
                    text: myData.overview ?? 'No overview available',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidgetPoppins(
                        text:
                            "${AppLocalizations.of(context)!.releasedate} : ${myData.releaseDate ?? 'Unknown'}",
                      ),
                      SizedBox(height: 8.0),
                      TextWidgetPoppins(
                        text:
                            "${AppLocalizations.of(context)!.originallanguage} : ${myData.originalLanguage ?? 'Unknown'}",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
