import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/DaypDashboard.dart';
import 'package:flutter_application_1/screens/DaypDashboardCount.dart';
import 'package:flutter_application_1/widgets/drawer-menu/DrawerMenu.dart';


class AppRoutes {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        // return MaterialPageRoute(
        //   builder: (_) => const DaypDashboardCount(),
        // );
        case '/Drawer':
        return MaterialPageRoute(
          builder: (_) => const DrawerMenu(),
        );
      case '/DaypScreen':
        return MaterialPageRoute(
          builder: (_) => const DaypDashboard(),
        );
      // case '/DaypCountScreen':
      //   return MaterialPageRoute(
      //     builder: (_) => const DaypDashboardCount(),
      //   );
      default:
        return MaterialPageRoute(
          builder: (_) => const DrawerMenu(),
        );
    }
  }
}
