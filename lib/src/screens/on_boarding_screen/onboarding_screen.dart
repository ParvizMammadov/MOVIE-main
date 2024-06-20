import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../global/const/colors.dart';
import '../../presentation/getX/controllers/pagecontroller.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = MyPageControllers();
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            onPageChangeCallback: (activePageIndex) =>
                controller.onPageChangedCallBack(activePageIndex),
            liquidController: controller.controller,
            pages: controller.pages,
            slideIconWidget: const Icon(Icons.arrow_back_ios_new_rounded),
            enableSideReveal: true,
          ),

          //skip
          Positioned(
              top: 40,
              right: 20,
              child: TextButton(
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: ConstantColor.buttonColorsTwo,
                      fontSize: 25,
                    ),
                  ),
                  onPressed: () => controller.skip())),
          Obx(
            () => Positioned(
                bottom: 20,
                child: AnimatedSmoothIndicator(
                    effect: const WormEffect(
                        activeDotColor: ConstantColor.myDarkColor,
                        dotHeight: 5),
                    activeIndex: controller.currentPage.value,
                    count: 3)),
          )
        ],
      ),
    );
  }
}
