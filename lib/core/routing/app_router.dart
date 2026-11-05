import 'package:flutter/material.dart';
import 'package:news_uni/feature/main_screen/presentation/view/widgets/app_section/app_section_view.dart';

import 'routes.dart';

//!_____Centralized Navigation___

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => AppSectionView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name} please check your route name and restart the app',
              ),
            ),
          ),
        );
    }
  }
}
