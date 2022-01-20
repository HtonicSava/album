import 'package:album/router/app_router.gr.dart';
import 'package:album/theme/custom_theme.dart';
import 'package:flutter/material.dart';

class RootApp extends StatelessWidget {
  RootApp({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
        theme: CustomTheme.lightTheme,
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate());
  }
}
