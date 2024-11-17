import 'package:flutter/material.dart';
import 'package:kanban_app/core/extensions/string_extension.dart';
import 'package:kanban_app/shared/theme/app_colors.dart';
import 'package:kanban_app/shared/theme/app_text_styles.dart';

class InitialsAvatar extends StatelessWidget {
  final String text;
  final double size;
  final double borderSize;

  const InitialsAvatar({
    super.key,
    required this.text,
    this.size = 40,
    this.borderSize = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      alignment: Alignment.center,
      padding: EdgeInsets.all(size / 5),
      decoration: BoxDecoration(
        color: colorData[text.initials.toLowerCase()[0]],
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        fit: BoxFit.fitHeight,
        alignment: Alignment.center,
        child: Text(
          text.initials,
          style: AppTextStyles.m18(AppColors.white),
        ),
      ),
    );
  }

  Map<String, Color> get colorData => {
        "a": const Color.fromRGBO(226, 95, 81, 1),
        "b": const Color.fromRGBO(242, 96, 145, 1),
        "c": const Color.fromRGBO(187, 101, 202, 1),
        "d": const Color.fromRGBO(149, 114, 207, 1),
        "e": const Color.fromRGBO(120, 132, 205, 1),
        "f": const Color.fromRGBO(91, 149, 249, 1),
        "g": const Color.fromRGBO(72, 194, 249, 1),
        "h": const Color.fromRGBO(69, 208, 226, 1),
        "i": const Color.fromRGBO(38, 166, 154, 1),
        "j": const Color.fromRGBO(82, 188, 137, 1),
        "k": const Color.fromRGBO(155, 206, 95, 1),
        "l": const Color.fromRGBO(212, 227, 74, 1),
        "m": const Color.fromRGBO(254, 218, 16, 1),
        "n": const Color.fromRGBO(247, 192, 0, 1),
        "o": const Color.fromRGBO(255, 168, 0, 1),
        "p": const Color.fromRGBO(255, 138, 96, 1),
        "q": const Color.fromRGBO(194, 194, 194, 1),
        "r": const Color.fromRGBO(143, 164, 175, 1),
        "s": const Color.fromRGBO(162, 136, 126, 1),
        "t": const Color.fromRGBO(163, 163, 163, 1),
        "u": const Color.fromRGBO(175, 181, 226, 1),
        "v": const Color.fromRGBO(179, 155, 221, 1),
        "w": const Color.fromRGBO(194, 194, 194, 1),
        "x": const Color.fromRGBO(124, 222, 235, 1),
        "y": const Color.fromRGBO(188, 170, 164, 1),
        "z": const Color.fromRGBO(173, 214, 125, 1),
        "": const Color.fromRGBO(173, 214, 125, 1),
      };
}
