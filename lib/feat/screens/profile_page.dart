import 'package:flutter/material.dart';
import 'package:questlist/core/constant/assets.dart';
import 'package:questlist/core/constant/profile.dart';
import 'package:questlist/core/constant/typography.dart';
import 'package:questlist/core/theme/base_color.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = "/profile_page";
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.neutral,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset(
              Assets.backgroundPhoto,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                decoration: const BoxDecoration(
                  color: BaseColors.neutral,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Developer.name,
                        style: Font.heading2,
                      ),
                      Text(
                        "${Developer.role1} - ${Developer.role2}",
                        style: Font.secondaryBodySmall,
                      ),
                      const SizedBox(height: 20),
                      const Text(Developer.description)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.3 - 50,
              left: 20,
              child: const CircleAvatar(
                radius: 55,
                backgroundImage: AssetImage(Assets.profilePhoto),
              ),
            )
          ],
        ),
      ),
    );
  }
}
