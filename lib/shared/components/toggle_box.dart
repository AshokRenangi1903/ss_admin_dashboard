import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class ToggleBox extends StatelessWidget {
  final String title;
  final Color? enabledColor, disabledColor;
  final bool isEnabled;
  final VoidCallback onTap;
  const new({
    super.key,
    required this.title,
    this.enabledColor,
    this.disabledColor,
    required this.isEnabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isEnabled ? AppColors.fillColor : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(
            width: 3,
            color: isEnabled
                ? (enabledColor ?? AppColors.primaryColor)
                : (disabledColor ?? AppColors.softText),
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
