import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final List<BoxShadow>? boxShadow;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: boxShadow),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.teal,
          foregroundColor: foregroundColor ?? AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
