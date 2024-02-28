import 'package:flutter/material.dart';
import 'package:questlist/core/constant/assets.dart';
import 'package:questlist/core/constant/profile.dart';
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
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Developer.name,
                        style: TextStyle(
                          color: BaseColors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${Developer.role1} - ${Developer.role2}",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(Developer.description)
                    ],
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 320,
              left: 20,
              child: CircleAvatar(
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
