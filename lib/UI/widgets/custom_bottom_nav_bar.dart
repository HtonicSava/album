import 'package:album/UI/icons/bottom_nav_bar_icons.dart';
import 'package:album/navigator/router_cubit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CustomBottomNavBar extends StatelessWidget {
  final BuildContext context;
  // final RouterState state;
  final TabsRouter tabsRouter;
  const CustomBottomNavBar(this.context, this.tabsRouter, {Key? key, } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: GestureDetector(
                // hoverColor: Colors.transparent,
                // focusColor: Colors.transparent,
                //
                // splashColor: Colors.transparent,
                onTap: () =>
                {
                  // context.read<RouterCubit>().goToPageAlbums()
                  tabsRouter.setActiveIndex(0)
                },
                child: Container(
                  color: Colors.transparent,
                  child: Icon(
                    BottomNavBar.albums,
                    size: 18,
                    color:

                    // _pageIndexFromState(context.read<RouterCubit>().state) ==
                    tabsRouter.activeIndex ==
                        0
                        ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedIconTheme!
                        .color
                        :
                    Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedIconTheme!
                        .color,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                // hoverColor: Colors.transparent,
                // focusColor: Colors.transparent,
                //
                // splashColor: Colors.transparent,
                onTap: () => {
                  // context.read<RouterCubit>().goToPageSearch()
                  tabsRouter.setActiveIndex(1)

                },
                child: Container(
                  color: Colors.transparent,

                  child: Icon(
                    BottomNavBar.search,
                    size: 18,
                    color:
                    // _pageIndexFromState(context.read<RouterCubit>().state) ==
                    tabsRouter.activeIndex ==

                            1
                        ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedIconTheme!
                        .color
                        :
                    Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedIconTheme!
                        .color,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          title: Text('Material Dialog'),


                        );
                      })
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Container(

                    decoration:  BoxDecoration(
                      // color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
                        color: Theme.of(context).indicatorColor,
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => {
                  // context.read<RouterCubit>().goToPageBucket()
                  tabsRouter.setActiveIndex(2)

                },
                child: Container(
                  color: Colors.transparent,


                  child: Icon(
                    BottomNavBar.bucket,
                    size: 18,
                    color:
                    // _pageIndexFromState(context.read<RouterCubit>().state) ==
                    tabsRouter.activeIndex ==

                            2
                        ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedIconTheme!
                        .color
                        :
                    Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedIconTheme!
                        .color,
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => {
                  // context.read<RouterCubit>().goToPagePersonalAccount()
                  tabsRouter.setActiveIndex(3)

                },
                child: Container(
                  color: Colors.transparent,

                  child: Icon(

                    BottomNavBar.account,
                    size: 18,
                    color:
                    // _pageIndexFromState(context.read<RouterCubit>().state) ==
                    tabsRouter.activeIndex ==

                        3
                        ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedIconTheme!
                        .color
                        :
                    Theme.of(context)
                        .bottomNavigationBarTheme
                        .unselectedIconTheme!
                        .color,
                  ),
                ),
              ),
            ),
          ],
        )

      // TabBar(
      //   // indicator: null,
      //   indicatorColor: Colors.transparent,
      //   labelColor: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color,
      //   unselectedLabelColor: Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme!.color,
      //   controller: _tabCtrl,
      //   onTap: (index) {
      //     switch (index) {
      //       case 1:
      //         context.read<RouterCubit>().goToPageSearchState();
      //         break;
      //       case 2:
      //
      //         showDialog(
      //             context: context,
      //             builder: (context) {
      //               return const AlertDialog(
      //                 title: Text('Material Dialog'),
      //
      //
      //               );
      //             });
      //         break;
      //       case 3:
      //         context.read<RouterCubit>().goToPageBucketState();
      //         break;
      //       case 4:
      //         context.read<RouterCubit>().goToPagePersonalAccountState();
      //         break;
      //       default:
      //         context.read<RouterCubit>().goToPageAlbumsState();
      //         break;
      //     }
      //   },
      //   tabs: _tabs,
      // ),
    );
  }

  int _pageIndexFromState(RouterState state) {
    if (state is PageSearchState) {
      return 1;
    } else if (state is PageBucketState) {
      return 3;
    } else if (state is PagePersonalAccountState) {
      return 4;
    } else {
      return 0;
    }
  }
}
