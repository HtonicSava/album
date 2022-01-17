import 'album_page.dart';
import 'config.dart';

AlbumPage getAlbumPage(PageConfig config){
  print('looking for ${config.route}');
  AlbumPage p = _routes[config.route]?.call(config.args) ?? NotFoundScreen(config.args);
  print('found $p');
  return p;
}

Map<String, AlbumPage Function(Map<String, dynamic>)> _routes = {
  // '/splash': (args) => SplashScreen(args),
  // '/login': (args) => LoginScreen(args),
  // '/pageA': (args) => PageA(args),
  // '/pageB': (args) => PageB(args),
};