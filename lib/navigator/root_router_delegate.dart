// import 'package:album/UI/screens/main_screen.dart';
// import 'package:album/UI/screens/second_level_screen.dart';
// import 'package:album/UI/screens/test_navigator_album.dart';
// import 'package:album/navigator/router_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/src/provider.dart';
//
// class RootRouterDelegate extends RouterDelegate<RouterState> {
//   final GlobalKey<NavigatorState> _navigatorKey;
//   final RouterCubit _routerCubit;
//
//   RootRouterDelegate(
//       GlobalKey<NavigatorState> navigatorKey, RouterCubit routerCubit)
//       : _navigatorKey = navigatorKey,
//         _routerCubit = routerCubit;
//
//   GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
//
//   @override
//   Widget build(BuildContext context) => Navigator(
//         key: navigatorKey,
//         pages: List.from([
//           _materialPage(valueKey: "mainScreen", child: const MainScreen()),
//           ..._extraPages,
//         ]),
//         onPopPage: _onPopPageParser,
//       );
//
//   bool _onPopPageParser(Route<dynamic> route, dynamic result) {
//     if (!route.didPop(result)) return false;
//     popRoute();
//     return true;
//   }
//
//   @override
//   Future<bool> popRoute() async {
//     // if (_routerCubit.state is PageTheAlbumState){
//     //
//     //   _routerCubit.popExtra();
//     //   print('Fgdfgdfgdg');
//     //   _routerCubit.goToPageAlbums('ghfgh');
//     //   return true;
//     // }
//     if (_extraPages.isNotEmpty) {
//       _routerCubit.popExtra();
//       return true;
//     }
//     if (_routerCubit.state is! PageAlbumsState) {
//       _routerCubit.goToPageAlbums();
//       return true;
//     }
//     return await _confirmAppExit();
//   }
//
//   List<Page> get _extraPages {
//
//
//
//     String? extraPageContent;
//
//     if (_routerCubit.state is PageTheAlbumState) {
//       extraPageContent =
//           (_routerCubit.state as PageTheAlbumState).extraPageContent;
//       return [
//         if (extraPageContent?.isNotEmpty ?? false)
//           _materialPage(
//             valueKey: "page-the-album",
//             child: SecondLevelScreen(text: extraPageContent!),
//           ),
//       ];
//     }
//
//     if (_routerCubit.state is PageAlbumsState) {
//       extraPageContent =
//           (_routerCubit.state as PageAlbumsState).extraPageContent;
//       return [
//         if (extraPageContent?.isNotEmpty ?? false)
//           // _materialPage(
//           //   valueKey: "page-1-extra",
//           //   child: SecondLevelScreen(text: extraPageContent!),
//           // ),
//           _materialPage(
//               valueKey: 'album-preview',
//               child: TestNavigatorAlbum(
//                 text: extraPageContent!,
//                 onBtnTap: (BuildContext context) {
//                   context.read<RouterCubit>().goToPageTheAlbum('The album preview');
//                 },
//               )),
//       ];
//     }
//     if (_routerCubit.state is PageSearchState) {
//       extraPageContent =
//           (_routerCubit.state as PageSearchState).extraPageContent;
//       return [
//         if (extraPageContent?.isNotEmpty ?? false)
//           _materialPage(
//             valueKey: "page-2-extra",
//             child: SecondLevelScreen(text: extraPageContent!),
//           ),
//       ];
//     }
//     if (_routerCubit.state is PageBucketState) {
//       extraPageContent =
//           (_routerCubit.state as PageBucketState).extraPageContent;
//       return [
//         if (extraPageContent?.isNotEmpty ?? false)
//           _materialPage(
//             valueKey: "page-3-extra",
//             child: SecondLevelScreen(text: extraPageContent!),
//           ),
//       ];
//     }
//     if (_routerCubit.state is PagePersonalAccountState) {
//       extraPageContent =
//           (_routerCubit.state as PagePersonalAccountState).extraPageContent;
//       return [
//         if (extraPageContent?.isNotEmpty ?? false)
//           _materialPage(
//             valueKey: "page-4-extra",
//             child: SecondLevelScreen(text: extraPageContent!),
//           ),
//       ];
//     }
//
//
//
//     return [];
//   }
//
//   Future<bool> _confirmAppExit() async =>
//       await showDialog<bool>(
//           context: navigatorKey.currentContext!,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text("Exit App"),
//               content: const Text("Are you sure you want to exit the app?"),
//               actions: [
//                 TextButton(
//                   child: const Text("Cancel"),
//                   onPressed: () => Navigator.pop(context, true),
//                 ),
//                 TextButton(
//                   child: const Text("Confirm"),
//                   onPressed: () => Navigator.pop(context, false),
//                 ),
//               ],
//             );
//           }) ??
//       true;
//
//   Page _materialPage({
//     required String valueKey,
//     required Widget child,
//   }) =>
//       MaterialPage(
//         key: ValueKey<String>(valueKey),
//         child: child,
//       );
//
// //It's not needed for bloc/cubit
//   @override
//   void addListener(VoidCallback listener) {}
//
// //It's not needed for bloc/cubit
//   @override
//   void removeListener(VoidCallback listener) {}
//
// //It's not needed for now
//   @override
//   Future<void> setNewRoutePath(RouterState configuration) async {}
// }
