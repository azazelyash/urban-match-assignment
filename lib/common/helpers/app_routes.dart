import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_match_task/screens/home_screen.dart';

class AppRoutes {
  static const initialRoute = "/";
  static const privacyPolicyRoute = "/homePage";

  static final GoRouter routes = GoRouter(
    initialLocation: initialRoute,
    routes: <GoRoute>[
      GoRoute(
        path: initialRoute,
        builder: (BuildContext context, state) => const HomeScreen(),
      ),
    ],
  );
}
