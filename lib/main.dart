import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ss_admin_dashboard/core/bindings/initial_binding.dart';
import 'package:ss_admin_dashboard/core/routes/routes.dart';
import 'package:ss_admin_dashboard/core/routes/routes_name.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Science Stories',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        textTheme: GoogleFonts.bricolageGrotesqueTextTheme(),
      ),
      localizationsDelegates: const [FlutterQuillLocalizations.delegate],
      initialBinding: InitialBinding(),
      initialRoute: RoutesName.authGate,
      getPages: AppRoutes.pages,
    );
  }
}
