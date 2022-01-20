//
// import 'package:album/navigator/root_router_delegate.dart';
// import 'package:album/navigator/router_cubit.dart';
// import 'package:album/theme/custom_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class AppRoot extends StatelessWidget {
//   final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//   // true - use freezed version; false - use non-freezed version
//   // static const bool _useFreezed = false;
//   AppRoot({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) => MultiBlocProvider(
//     providers: [
//       // BlocProvider(
//       //   create: (context) => FreezedRouterCubit(),
//       // ),
//       BlocProvider(
//         create: (context) => RouterCubit(),
//       ),
//     ],
//     child: MaterialApp(
//       theme: CustomTheme.lightTheme,
//       darkTheme: CustomTheme.lightTheme,
//       debugShowCheckedModeBanner: false,
//       home:  _router,
//     ),
//   );
//   Widget get _router => BlocBuilder<RouterCubit, RouterState>(
//     builder: (context, state) => Router(
//       routerDelegate: RootRouterDelegate(
//         navigatorKey,
//         context.read<RouterCubit>(),
//       ),
//       backButtonDispatcher: RootBackButtonDispatcher(),
//     ),
//   );
//   // Widget get _freezedRouter => BlocBuilder<FreezedRouterCubit, FreezedRouterState>(
//   //   builder: (context, state) => Router(
//   //     routerDelegate: RootFreezedRouterDelegate(
//   //       navigatorKey,
//   //       context.read<FreezedRouterCubit>(),
//   //     ),
//   //     backButtonDispatcher: RootBackButtonDispatcher(),
//   //   ),
//   // );
// }