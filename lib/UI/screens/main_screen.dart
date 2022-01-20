// import 'package:album/UI/icons/bottom_nav_bar_icons.dart';
// import 'package:album/UI/widgets/custom_bottom_nav_bar.dart';
// import 'package:album/navigator/router_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/src/provider.dart';
//
// import 'main_screen_tab_page.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// // class CustomTabController extends TabController{
// //   final int length;
// //   final int initialIndex;
// //   final TickerProvider vsync;
// //
// //   CustomTabController(
// //       {this.initialIndex = 0, required this.length, required this.vsync}) : super(vsync: vsync, length: length, initialIndex: initialIndex);
// //
// //   @override
// //   void animateTo(int value, { Duration duration = kTabScrollDuration, Curve curve = Curves.ease }) {
// //     _changeIndex(value, duration: duration, curve: curve);
// //   }
// //
// // }
//
// class _MainScreenState extends State<MainScreen>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabCtrl;
//
//   List<Tab> get _tabs => [
//         const Tab(
//           icon: Icon(Icons.home),
//           // text: "Albums",
//         ),
//         const Tab(
//           icon: Icon(Icons.access_alarm),
//           // text: "Search",
//         ),
//         Tab(
//           icon: Container(
//             width: 54,
//             height: 54,
//             decoration: const BoxDecoration(
//                 // color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
//                 color: Colors.red,
//                 shape: BoxShape.circle),
//             child: const Icon(
//               Icons.add,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         const Tab(
//           icon: Icon(Icons.outbond),
//           // text: "Bucket",
//         ),
//         const Tab(
//           icon: Icon(Icons.run_circle),
//           // text: "Personal Account",
//         ),
//       ];
//
//   @override
//   void initState() {
//     super.initState();
//     _tabCtrl = TabController(
//       initialIndex: _pageIndexFromState(context.read<RouterCubit>().state),
//       vsync: this,
//       length: _tabs.length,
//       // length: 5,
//     );
//   }
//
//   @override
//   void dispose() {
//     _tabCtrl?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(_) => BlocConsumer<RouterCubit, RouterState>(
//         listener: _listener,
//         builder: (context, state) => Scaffold(
//           backgroundColor: Theme.of(context).colorScheme.primary,
//           body: _body(context),
//           bottomNavigationBar: CustomBottomNavBar(context),
//           // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
//           // floatingActionButton: FloatingActionButton(
//           //   child: Container(
//           //     width: 54,
//           //     height: 54,
//           //     decoration: BoxDecoration(
//           //         color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
//           //         shape: BoxShape.circle
//           //     ),
//           //     child: const Icon(
//           //
//           //       Icons.add,
//           //       color: Colors.white,
//           //     ),
//           //   ),
//           //   onPressed: () {
//           //     // Overlay.of(context).insert(entry);
//           //   },
//           // ),
//         ),
//       );
//
//   void _listener(BuildContext context, RouterState state) {
//     final int pageIndex =
//         _pageIndexFromState(context.read<RouterCubit>().state);
//     if (_tabCtrl != null) {
//       _tabCtrl?.animateTo(pageIndex, curve: Curves.easeInOut);
//     }
//   }
//
//   Widget _body(BuildContext context) => TabBarView(
//         controller: _tabCtrl,
//         physics: const NeverScrollableScrollPhysics(),
//         children: _pages(context),
//       );
//
//   List<Widget> _pages(BuildContext context) => [
//         MainScreenTabPage(
//           text: "Albums",
//           onBtnTap: () =>
//               context.read<RouterCubit>().goToPageAlbums("The album"),
//         ),
//         MainScreenTabPage(
//           text: "Search",
//           onBtnTap: () =>
//               context.read<RouterCubit>().goToPageSearch("Search"),
//         ),
//         const Dialog(
//           child: Center(child: Text('Ало')),
//         ),
//         MainScreenTabPage(
//           text: "Bucket",
//           onBtnTap: () =>
//               context.read<RouterCubit>().goToPageBucket("Bucket"),
//         ),
//         MainScreenTabPage(
//           text: "Personal account",
//           onBtnTap: () => context
//               .read<RouterCubit>()
//               .goToPagePersonalAccount("Personal account"),
//         ),
//       ];
//
//   Widget _bottomNavigationBar(
//     BuildContext context,
//     RouterState state,
//   ) =>
//       Container(
//           height: 54,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(28),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Expanded(
//                 child: GestureDetector(
//                   // hoverColor: Colors.transparent,
//                   // focusColor: Colors.transparent,
//                   //
//                   // splashColor: Colors.transparent,
//                   onTap: () =>
//                       {context.read<RouterCubit>().goToPageAlbums()},
//                   child: Container(
//                     color: Colors.transparent,
//                     child: Icon(
//                       BottomNavBar.albums,
//                       size: 18,
//                       color:
//                           _pageIndexFromState(context.read<RouterCubit>().state) ==
//                                   0
//                               ? Theme.of(context)
//                                   .bottomNavigationBarTheme
//                                   .selectedIconTheme!
//                                   .color
//                               : Theme.of(context)
//                                   .bottomNavigationBarTheme
//                                   .unselectedIconTheme!
//                                   .color,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   // hoverColor: Colors.transparent,
//                   // focusColor: Colors.transparent,
//                   //
//                   // splashColor: Colors.transparent,
//                   onTap: () => {
//                     context.read<RouterCubit>().goToPageSearch()
//
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//
//                     child: Icon(
//                       BottomNavBar.search,
//                       size: 18,
//                       color:
//                           _pageIndexFromState(context.read<RouterCubit>().state) ==
//                                   1
//                               ? Theme.of(context)
//                                   .bottomNavigationBarTheme
//                                   .selectedIconTheme!
//                                   .color
//                               : Theme.of(context)
//                                   .bottomNavigationBarTheme
//                                   .unselectedIconTheme!
//                                   .color,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () => {
//                             showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return const AlertDialog(
//                                     title: Text('Material Dialog'),
//
//
//                                   );
//                                 })
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 6.0),
//                     child: Container(
//
//                       decoration:  BoxDecoration(
//                           // color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
//                           color: Theme.of(context).indicatorColor,
//                           shape: BoxShape.circle),
//                       child: const Icon(
//                         Icons.add,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () => {
//                     context.read<RouterCubit>().goToPageBucket()
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//
//
//                     child: Icon(
//                       BottomNavBar.bucket,
//                       size: 18,
//                       color:
//                           _pageIndexFromState(context.read<RouterCubit>().state) ==
//                                   3
//                               ? Theme.of(context)
//                                   .bottomNavigationBarTheme
//                                   .selectedIconTheme!
//                                   .color
//                               : Theme.of(context)
//                                   .bottomNavigationBarTheme
//                                   .unselectedIconTheme!
//                                   .color,
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () => {
//                     context.read<RouterCubit>().goToPagePersonalAccount()
//                   },
//                   child: Container(
//                     color: Colors.transparent,
//
//                     child: Icon(
//
//                       BottomNavBar.account,
//                       size: 18,
//                       color:
//                           _pageIndexFromState(context.read<RouterCubit>().state) ==
//                                   4
//                               ? Theme.of(context)
//                                   .bottomNavigationBarTheme
//                                   .selectedIconTheme!
//                                   .color
//                               : Theme.of(context)
//                                   .bottomNavigationBarTheme
//                                   .unselectedIconTheme!
//                                   .color,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           )
//
//           // TabBar(
//           //   // indicator: null,
//           //   indicatorColor: Colors.transparent,
//           //   labelColor: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
//           //   unselectedLabelColor: Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme!.color,
//           //   controller: _tabCtrl,
//           //   onTap: (index) {
//           //     switch (index) {
//           //       case 1:
//           //         context.read<RouterCubit>().goToPageSearchState();
//           //         break;
//           //       case 2:
//           //
//           //         showDialog(
//           //             context: context,
//           //             builder: (context) {
//           //               return const AlertDialog(
//           //                 title: Text('Material Dialog'),
//           //
//           //
//           //               );
//           //             });
//           //         break;
//           //       case 3:
//           //         context.read<RouterCubit>().goToPageBucketState();
//           //         break;
//           //       case 4:
//           //         context.read<RouterCubit>().goToPagePersonalAccountState();
//           //         break;
//           //       default:
//           //         context.read<RouterCubit>().goToPageAlbumsState();
//           //         break;
//           //     }
//           //   },
//           //   tabs: _tabs,
//           // ),
//           );
//
//   int _pageIndexFromState(RouterState state) {
//     if (state is PageSearchState) {
//       return 1;
//     } else if (state is PageBucketState) {
//       return 3;
//     } else if (state is PagePersonalAccountState) {
//       return 4;
//     } else {
//       return 0;
//     }
//   }
//
//   void _dismissDialog() {
//     Navigator.pop(context);
//   }
// }
