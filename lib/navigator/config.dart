import 'package:album/navigator/routes.dart';
import 'package:equatable/equatable.dart';

import 'album_page.dart';

class PageConfig extends Equatable{

  ///full path to the page
  late final Uri path;
  late final String route;
  final String? name;
  final Map<String, dynamic> args = {};
  late final AlbumPage page;

  PageConfig({
    required String location,
    Map<String, dynamic>? args,
    this.name,
  }){
    path = location.isNotEmpty ? Uri.parse(location) : Uri.parse('/');
    route = path.toString();
    this.args.addIfNotNull(args);

    ///get the page from defined pages
    page = getAlbumPage(this);
  }
  @override
  String toString() {
    return 'PageConfig: path = $path, args = $args';
  }

  @override
  List<Object?> get props => [path, args];

}

extension AddNullableMap on Map {
  void addIfNotNull(Map? other) {
    if (other != null) {
      addAll(other);
    }
  }
}