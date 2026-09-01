import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class OptionCard extends StatelessWidget {
  final String optionText;
  final bool isCorrect;
  const new({super.key, required this.optionText, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.tealShadow.withAlpha(100)
            : Colors.white.withAlpha(0),
        border: isCorrect
            ? BoxBorder.all(color: AppColors.teal, width: 2)
            : BoxBorder.all(
                color: AppColors.goldBorderColor.withAlpha(180),
                width: 2,
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(optionText),
    );
  }
}
