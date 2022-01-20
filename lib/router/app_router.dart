import 'package:album/router/pages_models/albums_page.dart';
import 'package:album/router/pages_models/bucket_page.dart';
import 'package:album/router/pages_models/main_page.dart';
import 'package:album/router/pages_models/personal_account_page.dart';
import 'package:album/router/pages_models/personal_account_page_redact.dart';
import 'package:album/router/pages_models/search_page.dart';
import 'package:album/router/pages_models/single_album_page.dart';
import 'package:album/router/pages_models/single_album_page_redact.dart';
import 'package:auto_route/auto_route.dart';



@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: MainPage, children: [
      AutoRoute(path: 'albums', name: 'AlbumsRouter', page: EmptyRouterPage,
        children: [
          AutoRoute(
            path: '',
            page: AlbumsPage,

          ),
          AutoRoute(
            path: ':albumId',
            page: SingleAlbumPage,
          ),
          AutoRoute(
            path: 'albumRedactor',
            page: SingleAlbumPageRedact
          )

        ]
      ),
      AutoRoute(path: 'bucket', name: 'BucketRouter', page: BucketPage),
      AutoRoute(path: 'search', name: 'SearchRouter', page: SearchPage),
      AutoRoute(path: 'personalAccount', name: 'PersonalAccountRouter', page: EmptyRouterPage, children: [
        AutoRoute(
            path: '',
            page: PersonalAccountPage
        ),

        AutoRoute(
          path: 'PARedact',
          page: PersonalAccountPageRedact
        )
      ]),
    ]),

  ],
)
class $AppRouter {}