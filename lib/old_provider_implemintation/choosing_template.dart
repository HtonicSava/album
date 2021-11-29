import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'choosing_template_provider.dart';
import 'sheet_preview.dart';
import 'sheet_natural.dart';

class ChoosingTemplate extends StatelessWidget {
  const ChoosingTemplate({Key? key}) : super(key: key);

  _changeActiveTemplate(BuildContext context, index) {
    ChoosingTemplateProvider choosingTemplateProvider =
        Provider.of(context, listen: false);
    choosingTemplateProvider.changeActiveTemplate(sheets[index]);
  }

  static const List sheets = [
    [
      {'width': 0.6, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.6, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.6, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.5, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.5, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.7, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.7, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.7, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.5, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.9, 'height': 0.2, 'top': 0.4, 'left': 0.1},
      {'width': 0.3, 'height': 0.2, 'top': 0.1, 'left': 0.8},
    ],
    [
      {'width': 0.7, 'height': 0.2, 'top': 0.7, 'left': 0.2},
      {'width': 0.7, 'height': 0.2, 'top': 0.4, 'left': 0.5},
      {'width': 0.9, 'height': 0.2, 'top': 0.0, 'left': 1.0},
    ],
    [
      {'width': 1.0, 'height': 0.3, 'top': 0.0, 'left': 0.0},
      {'width': 1.0, 'height': 0.3, 'top': 0.5, 'left': 0.0},
      {'width': 1.0, 'height': 0.3, 'top': 1.0, 'left': 0.0},
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChoosingTemplateProvider>(
      create: (context) => ChoosingTemplateProvider(),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: sheets.length,
                itemBuilder: (context, index) {
                  return SheetPreview(
                    photos: sheets[index],
                    callback: () => {_changeActiveTemplate(context, index)},
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 16);
                },
              ),
            ),
          ),
          Expanded(
            child: Consumer<ChoosingTemplateProvider>(
              builder: (context, choosingTemplateProvider, child) =>
                  choosingTemplateProvider.activeSheet.isNotEmpty
                      ? SheetNatural(
                          provider: choosingTemplateProvider,
                          photos: choosingTemplateProvider.activeSheet,
                          callback: () => {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        elevation: 1,
                                        child: FractionallySizedBox(
                                          widthFactor: 1.0,
                                          heightFactor: 0.5,
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                Center(
                                                  child: Container(
                                                    color: Colors.green
                                                        .withOpacity(0.2),
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 80),
                                                  child: Center(
                                                    child: AspectRatio(
                                                      aspectRatio:
                                                          choosingTemplateProvider
                                                              .activePhotoPlaceholderAspectRatio,
                                                      child: Container(
                                                        color: Colors.red
                                                            .withOpacity(0.4),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    })
                              })
                      : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
