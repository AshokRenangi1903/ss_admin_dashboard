import 'package:flutter/material.dart';
import 'package:ss_admin_dashboard/features/era/widgets/era_grid.dart';

class EraPage extends StatelessWidget {
  const EraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        // AddEraCard(),
        Expanded(child: EraGrid()),
      ],
    );
  }
}
