import 'package:firebase_auth/firebase_auth.dart';
import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_dovie/src/global/const/colors.dart';
import 'package:movie_dovie/src/screens/home_screen/home_screen.dart';
import 'package:movie_dovie/src/screens/profile_screen.dart/widgets/language_widgets.dart';
import 'package:movie_dovie/src/screens/profile_screen.dart/widgets/my_drawer.dart';
import 'package:movie_dovie/src/screens/profile_screen.dart/widgets/my_list_tile.dart';
import 'package:movie_dovie/src/screens/profile_screen.dart/widgets/user_account_configuration.dart';
import 'package:movie_dovie/src/widgets/background_image_widget.dart';
import '../../data/servises_auth.dart';
import '../../presentation/riverpod/user_providers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../login_screen.dart/login_screen.dart';

class UserProfile extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final AuthServise _auth = AuthServise();
    return BackGroundImageWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: myDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            30.verticalSpace,
            Card(
              elevation: 20.rs,
              color: Color(0xFFFFFFFF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300.rw,
                    height: 150.rh,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 270.rw),
                          child: InkWell(
                            onTap: () => Flexify.go(UserAccountConfiguration()),
                            child: Icon(
                              Icons.edit,
                              size: 20.rs,
                              color: Color(0xFF000000),
                            ),
                          ),
                        ),
                        CircleAvatar(backgroundImage: FileImage(user.image)),
                        Text(
                          '${user.name}',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 13.rt,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '${user.surname}',
                          style: TextStyle(
                              color: Color(0xFF000000),
                              fontSize: 13.rt,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            45.verticalSpace,
            AppLanguages(),
            10.verticalSpace,
            myListTile(
                ontap: () async {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor: ConstantColor.whiteColor,
                      title: Text(
                        AppLocalizations.of(context)!.exit.toString(),
                        style: TextStyle(color: ConstantColor.buttonColorsOne),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text(
                            'Cancel',
                            style:
                                TextStyle(color: ConstantColor.buttonColorsOne),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await _auth.signOut();
                            Flexify.go(LoginScreen());
                          },
                          child: const Text(
                            'OK',
                            style:
                                TextStyle(color: ConstantColor.buttonColorsTwo),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: Icons.login_outlined,
                text: AppLocalizations.of(context)!.logout.toString()),
          ],
        ),
      ),
    );
  }
}
