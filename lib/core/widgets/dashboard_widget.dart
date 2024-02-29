import 'package:flutter/material.dart';
import 'package:questlist/core/constant/typography.dart';
import 'package:questlist/core/theme/base_color.dart';
import 'package:questlist/feat/data/models/dashboard_item.dart';
import 'package:questlist/feat/data/models/todo.dart';
import 'package:questlist/feat/screens/dashboard_page.dart';

class DashboardWidget extends StatelessWidget {
  final Item item;
  final List<ToDo> list;
  const DashboardWidget({
    super.key,
    required this.item,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          DashbordPage.routeName,
          arguments: item,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: BaseColors.primaryGrey,
        ),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 2.5,
        height: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: BaseColors.primaryBlue,
                  ),
                  child: Icon(item.icon),
                ),
                Text(
                  list.length.toString(),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: BaseColors.black,
                  ),
                )
              ],
            ),
            Text(
              item.itemName,
              style: Font.heading3,
            )
          ],
        ),
      ),
    );
  }
}
