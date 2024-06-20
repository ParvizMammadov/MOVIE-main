import 'package:flexify/flexify.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import 'package:movie_dovie/src/global/const/colors.dart';
import 'package:movie_dovie/src/global/const/image.dart';
import 'package:movie_dovie/src/global/const/texts.dart';
import 'package:movie_dovie/src/screens/login_screen.dart/login_screen.dart';
import '../../../domains/models/onboarding_model.dart';
import '../../../screens/on_boarding_screen/widgets/onboarding_view.dart';

class MyPageControllers extends GetxController {
  final controller = LiquidController();
  RxInt currentPage = 0.obs;
  final pages = [
    OnBoardingView(
        models: OnBoardingModel(myPageOneImage, myOnePageTextOne,
            myOnePageTextTwo, ConstantColor.myPageOneColor, 200.rw, 300)),
    OnBoardingView(
        models: OnBoardingModel(myPageTwoImage, myTwoPageTextOne,
            myTwoPageTextTwo, ConstantColor.buttonColorsOne, 200.rw, 600)),
    OnBoardingView(
        models: OnBoardingModel(myPageThreeImage, myThreePageTextOne,
            myThreePageTextTwo, ConstantColor.whiteColor, 250.rw, 400))
  ];
  void onPageChangedCallBack(int activePageIndex) {
    currentPage.value = activePageIndex;
  }

  skip() => Flexify.go(LoginScreen(),
      animation: FlexifyRouteAnimations.scale,
      animationDuration: Duration(seconds: 1));
  animated() {
    int nextPage = controller.currentPage + 1;
    controller.animateToPage(page: nextPage);
  }
}
