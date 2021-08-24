import 'package:flutter/material.dart';
import 'package:flutter_breaking/app_router.dart';

void main() {
  runApp(BreakingBadApp(
    appRouter: AppRouter(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  final AppRouter appRouter;
  const BreakingBadApp({required this.appRouter});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Breaking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
