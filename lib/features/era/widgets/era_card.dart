import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/chip_text.dart';

class EraCard extends StatelessWidget {
  final String title, startYear, endYear, imageUrl;
  final int storiesCount;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const EraCard({
    super.key,
    required this.title,
    required this.endYear,
    required this.startYear,
    required this.imageUrl,
    required this.onTap,
    required this.onUpdate,
    required this.onDelete,
    required this.storiesCount,
    re,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 300,
      child: InkWell(
        onTap: onTap,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Icon(Icons.image_not_supported);
                        },
                      ),
                    ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              onPressed: onUpdate,
                              icon: Icon(
                                Icons.edit,
                                size: 18,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(width: 4),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              onPressed: onDelete,
                              icon: Icon(
                                Icons.delete,
                                size: 18,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // --------------------
                    //  Stories Count
                    // --------------------
                    // Positioned(
                    //   top: 4,
                    //   left: 8,
                    //   child: Row(
                    //     children: [
                    //       ChipText(
                    //         title: "Stories: $storiesCount",
                    //         bgcolor: AppColors.teal,
                    //         color: AppColors.white,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  width: double.infinity,
                  color: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(title), Text("$startYear - $endYear")],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
