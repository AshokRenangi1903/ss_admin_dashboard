import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/shared/colors/colors.dart';
import 'package:ss_admin_dashboard/shared/components/chip_text.dart';
import 'package:ss_admin_dashboard/shared/helpers/format_date_time.dart';

class StoryCard extends StatelessWidget {
  final String title, description, imageUrl, eraTitle, updatedAt;
  final VoidCallback? onDelete, onEdit, onTap;
  const StoryCard({
    super.key,
    required this.description,
    required this.title,
    required this.imageUrl,
    required this.updatedAt,
    this.onDelete,
    this.onEdit,
    required this.eraTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 90,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),

          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  // -------------------------------
                  // image
                  // -------------------------------
                  SizedBox(
                    height: 60,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Icon(Icons.image_not_supported);
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 20),

                  // -------------------------------
                  //title & Description
                  // -------------------------------
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            ChipText(title: eraTitle),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.midText,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // -------------------------------
                  // Buttons
                  // -------------------------------
                  Row(
                    children: [
                      onEdit != null
                          ? IconButton(
                              onPressed: onEdit,
                              icon: Icon(Icons.edit, color: AppColors.teal),
                            )
                          : SizedBox.shrink(),
                      onDelete != null
                          ? IconButton(
                              onPressed: onDelete,
                              icon: Icon(Icons.delete, color: Colors.red),
                            )
                          : SizedBox.shrink(),
                    ],
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Positioned(
                bottom: 2,
                right: 8,
                child: Text(
                  "Updated @${formatDateTime(updatedAt)}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: AppColors.softInk,
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
