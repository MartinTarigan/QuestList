import 'package:flutter/material.dart';
import 'package:questlist/core/theme/base_color.dart';

class Font {
  static TextStyle heading1 = const TextStyle(
    color: BaseColors.white,
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );
  static TextStyle heading2 = const TextStyle(
    color: BaseColors.black,
    fontSize: 25,
    fontWeight: FontWeight.w700,
  );
  static TextStyle heading3 = const TextStyle(
    color: BaseColors.secondaryGrey,
    fontSize: 19,
    fontWeight: FontWeight.w700,
  );
  static TextStyle primaryBodyLarge = const TextStyle(
    color: BaseColors.white,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static TextStyle secondaryBodyLarge = const TextStyle(
    color: BaseColors.secondaryGrey,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static TextStyle tertiaryBodyLarge = const TextStyle(
    color: BaseColors.black,
    fontWeight: FontWeight.w700,
    fontSize: 20,
  );
  static TextStyle primaryBodyMedium = const TextStyle(
    color: BaseColors.white,
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );
  static TextStyle secondaryBodyMedium = const TextStyle(
    color: BaseColors.secondaryGrey,
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );
  static TextStyle tertiaryBodyMedium = const TextStyle(
    color: BaseColors.black,
    fontWeight: FontWeight.w600,
    fontSize: 15,
  );
  static TextStyle primaryBodySmall = const TextStyle(
    color: BaseColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );
  static TextStyle secondaryBodySmall = const TextStyle(
    color: BaseColors.secondaryGrey,
    fontWeight: FontWeight.w400,
    fontSize: 14,
  );

  static TextStyle splashScreenTextStyle = const TextStyle(
    color: BaseColors.white,
    fontSize: 50,
    fontWeight: FontWeight.w700,
  );
}
