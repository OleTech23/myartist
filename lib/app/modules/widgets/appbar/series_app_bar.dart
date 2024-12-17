import 'package:flutter/material.dart';

class SeriesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int activeIndex;
  final int totalIndex;
  final Color backgroundColor;
  final Color textColor;

  SeriesAppBar({
    super.key,
    required this.title,
    required this.activeIndex,
    required this.totalIndex,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              color: textColor.withAlpha(10),
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 5.0,
              ),
              child: Text(
                "$activeIndex / $totalIndex",
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
