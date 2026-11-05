import 'package:flutter/material.dart';
import 'package:news_uni/core/routing/app_router.dart';
import 'package:news_uni/core/routing/routes.dart';

class NewsApp extends StatelessWidget {
  const NewsApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',

      onGenerateRoute: appRouter.generateRoute,
      initialRoute: Routes.mainScreen,
    );
  }
}
