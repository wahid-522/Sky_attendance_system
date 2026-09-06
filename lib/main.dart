import 'package:flutter/material.dart';
import 'package:sky_attendance/core/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String? initialRoute;

  const MyApp({
    super.key,
    this.initialRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sky Academy Attendance',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: initialRoute ?? AppRoutes.login,
      routes: AppRoutes.routes,
    );
  }
}
