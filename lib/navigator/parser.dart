
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'album_page.dart';
import 'config.dart';

class AlbumRouteInformationParser extends RouteInformationParser<PageConfig> {
  ///get a location (path) from the system and build your route wrapping object
  @override
  Future<PageConfig> parseRouteInformation(RouteInformation routeInformation) async{
    final String path = routeInformation.location ?? '';
    PageConfig config = PageConfig(location: path);
    return config;
  }

  @override
  RouteInformation? restoreRouteInformation(PageConfig configuration) {
    return RouteInformation(location: configuration.path.toString());
  }

}

