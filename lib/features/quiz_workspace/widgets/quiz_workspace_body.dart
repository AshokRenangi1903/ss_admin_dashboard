import 'package:flutter/material.dart';

import 'package:ss_admin_dashboard/features/quiz_workspace/widgets/questions_list_view.dart';

class QuizWorkspaceBody extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: QuestionsListView());
  }
}
