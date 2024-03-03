import 'package:flutter/material.dart';
import 'package:questlist/core/constant/assets.dart';
import 'package:questlist/core/constant/typography.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/core/widgets/navbar.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/splash_screen";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(
            context,
            PersistentBottomNavPage.routeName,
          );
        });
      },
    );
    return Scaffold(
      backgroundColor: BaseColors.primaryBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Assets.appLogo,
                  scale: 3,
                ),
                Text(
                  "Todos",
                  style: Font.splashScreenTextStyle,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
