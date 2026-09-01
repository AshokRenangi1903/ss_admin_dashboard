import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/controllers/quiz_workspace_controller.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/widgets/quiz_workspace_body.dart';
import 'package:ss_admin_dashboard/features/quiz_workspace/widgets/quiz_workspace_header.dart';
class QuizWorkspace extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final quizWorkspaceController = Get.put(QuizWorkspaceController());

    return Scaffold(
      body: Column(
        children: [
          QuizWorkspaceHeader(),
         
          QuizWorkspaceBody(),
        ],
      ),
    );
  }
}
