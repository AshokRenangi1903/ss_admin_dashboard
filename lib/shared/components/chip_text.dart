import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class ChipText extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool? textCenter;
  final Color? bgcolor, color, iconColor;
  const ChipText({
    super.key,
    required this.title,
    this.bgcolor,
    this.color,
    this.icon,
    this.iconColor,
    this.textCenter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: bgcolor ?? AppColors.fillColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: textCenter == true
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          icon != null
              ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(icon, color: iconColor, size: 14),
                )
              : SizedBox.shrink(),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color ?? AppColors.darkText,
            ),
          ),
        ],
      ),
    );
  }
}
