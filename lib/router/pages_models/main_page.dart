import 'package:album/UI/widgets/custom_bottom_nav_bar.dart';
import 'package:album/router/app_router.dart';
import 'package:album/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app_router.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AutoTabsRouter(
        // animationCurve:
        // appBarBuilder: (_, tabsRouter) => AppBar(
        //   backgroundColor: Colors.red.shade200,
        //   title: const Text('Main page'),
        // ),

        // backgroundColor: Colors.white,
        routes: const [
          AlbumsRouter(),
          SearchRouter(),
          BucketRouter(),
          PersonalAccountRouter(),
        ],
        builder: (context, child, animation) {
          final tabsRouter = context.tabsRouter;
          // TODO оболочка для страниц, чтобы избежать постоянного копирования кода AppBar (добавить блок, чтобы избежать полной перерисовки)

          return Scaffold(
            body: FadeTransition(
              opacity: animation,
              child: child,
            ),
            bottomNavigationBar: CustomBottomNavBar(context, tabsRouter),
          );
        },
      ),
    );
  }
}
