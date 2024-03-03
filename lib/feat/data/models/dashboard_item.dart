import 'package:flutter/material.dart';
import 'package:Todos/core/theme/base_color.dart';

class DashboardItem {
  static List<Item> itemList = [
    Item(
        itemName: "Today",
        color: BaseColors.primaryBlue,
        icon: Icons.calendar_today_rounded),
    Item(
      itemName: "All",
      color: BaseColors.primaryBlue,
      icon: Icons.calendar_month_sharp,
    ),
    Item(
      itemName: "Completed",
      color: BaseColors.primaryBlue,
      icon: Icons.alarm_on,
    ),
    Item(
      itemName: "Scheduled",
      color: BaseColors.primaryBlue,
      icon: Icons.alarm,
    ),
  ];
}

class Item {
  String itemName;
  Color color;
  IconData icon;

  Item({required this.itemName, required this.color, required this.icon});
}
