import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';

class StepItemWidget extends StatelessWidget {
  final bool isActive, isCompleted;

  final String title;
  const StepItemWidget({
    super.key,
    required this.title,
    required this.isActive,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.fillColor,
            border: Border.all(color: AppColors.white, width: 2),
          ),
          child: Center(
            child: isCompleted
                ? Icon(
                    Icons.done,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  )
                : isActive
                ? Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryColor,
                    ),
                  )
                : null,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w100,
            color: AppColors.fillColor,
          ),
        ),
      ],
    );
  }
}
