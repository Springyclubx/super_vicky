import 'package:flutter/material.dart';
import 'package:super_vicky/infrastructure/presentation/screens/main_screen/main_screen.dart';
import 'package:super_vicky/infrastructure/presentation/screens/form_data/form_data_screen.dart';

import '../domain/constants/route_default.dart';

/// All routes on program
Map<String, WidgetBuilder> routes() {
  return {
    RouteDefault.mainScreen: (context) => const MainScreen(),
    RouteDefault.formScreen: (context) => const RegisterScreen(),
  };
}
