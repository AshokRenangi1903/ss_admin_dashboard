import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

Color getDifficultyColor(String difficulty) {
  switch (difficulty.toUpperCase()) {
    case "EASY":
      return AppColors.tealShadow;

    case 'MODERATE':
      return AppColors.goldBorderColor;

    case 'ADVANCED':
      return Colors.red;

    default:
      return Colors.grey;
  }
}
