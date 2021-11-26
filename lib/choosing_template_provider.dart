import 'package:flutter/material.dart';

class ChoosingTemplateProvider extends ChangeNotifier {
  // List? activeSheet;

  // List activeSheet = [
  //   {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2},
  //   {'width': 0.6, 'height': 0.2, 'top': 0.4, 'left': 0.5},
  //   {'width': 0.6, 'height': 0.2, 'top': 0.1, 'left': 0.8},
  // ];

  List activeSheet = [];
  late double activePhotoPlaceholderAspectRatio;

  void changeActiveTemplate(sheet) {
    activeSheet = sheet;
    notifyListeners();
  }

  void openPhotoPlaceholder(double proportion) {
    activePhotoPlaceholderAspectRatio = proportion;
    print(' proportion is $activePhotoPlaceholderAspectRatio');
    notifyListeners();

  }
}
