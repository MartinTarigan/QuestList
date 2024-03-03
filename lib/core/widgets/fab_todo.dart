import 'package:flutter/material.dart';
import 'package:Todos/core/constant/typography.dart';
import 'package:Todos/core/theme/base_color.dart';

class FABToDo extends StatelessWidget {
  final String buttonName;
  final Function()? onTap;
  const FABToDo({
    super.key,
    required this.buttonName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      height: 50,
      child: FloatingActionButton(
        backgroundColor: BaseColors.purple,
        splashColor: BaseColors.primaryBlue,
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                buttonName,
                overflow: TextOverflow.ellipsis,
                style: Font.primaryBodyLarge,
              ),
            ),
            const SizedBox(width: 10),
            const Icon(
              Icons.edit,
              color: BaseColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
