import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:movie_dovie/src/global/const/colors.dart';
import 'package:movie_dovie/src/screens/favorite_page/favorite_screen.dart';
import 'package:movie_dovie/src/screens/home_screen/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_dovie/src/screens/profile_screen.dart/user_profile_screen.dart';
import 'package:movie_dovie/src/screens/search_screen/search_screen.dart';
import 'package:movie_dovie/src/screens/watched_video/watched_video_screen.dart';
import 'widget/tab_widget.dart';

class BottomTabbar extends StatefulWidget {
  const BottomTabbar({super.key});

  @override
  State<BottomTabbar> createState() => _BottomTabbarState();
}

class _BottomTabbarState extends State<BottomTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late int activeIndex;

  @override
  void initState() {
    super.initState();
    activeIndex = 0;
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const HomeScreen(),
                  FavoriteScreen(),
                  SearchScreen(),
                  WatchedVideosScreen(),
                  UserProfile()
                ],
              ),
            ),
          ],
        ),
      ),
      extendBody: true,
      // //////////////////////////TABBAR//////////////////////////////////////////////

      bottomSheet: SizedBox(
        width: double.infinity,
        height: 115.rh,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: -10.rh,
              child: Transform.scale(
                scale: 1.1,
                child: SvgPicture.asset(
                  "assets/svg/navbar.svg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: TabBar(
                padding: EdgeInsets.only(right: 4.rw, top: 6.rh),
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                controller: _tabController,
                dividerHeight: 0,
                indicatorColor: Colors.transparent,
                onTap: (index) {
                  setState(() {
                    activeIndex = index;
                  });
                },
                tabs: [
                  Padding(
                    padding: EdgeInsets.only(top: 50.rh),
                    child: TabWidget(
                      text: "home",
                      isActive: activeIndex == 0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.rw, top: 50.rh),
                    child: Transform.scale(
                      scale: 1.1,
                      child: TabWidget(
                        text: "favorite",
                        isActive: activeIndex == 1,
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 1.3,
                    child: CircleAvatar(
                      backgroundColor: ConstantColor.buttonColorsOne,
                      radius: 30.rs,
                      child: SvgPicture.asset(
                        width: 17.rw,
                        "assets/svg/search.svg",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.rw, top: 50.rh),
                    child: Transform.scale(
                      scale: 1.1,
                      child: TabWidget(
                        text: "notification",
                        isActive: activeIndex == 3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 50.rh),
                    child: TabWidget(
                      text: "profile",
                      isActive: activeIndex == 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
