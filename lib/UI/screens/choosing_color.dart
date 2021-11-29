import 'dart:ffi';

import 'package:album/bloc/custom_color_bloc.dart';
import 'package:album/bloc/custom_color_event.dart';
import 'package:album/bloc/custom_color_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoosingColor extends StatelessWidget {
  const ChoosingColor({Key? key}) : super(key: key);

  static const List<Color> colors = [
    Colors.red,
    Colors.black,
    Colors.deepOrangeAccent,
    Colors.limeAccent
  ];

  void _changeActiveBox(BuildContext context, double width, Color color) {
    final customColorBloc = BlocProvider.of<CustomColorBloc>(context);

    customColorBloc.add(GetBigSheet(width, color));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 150,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (context, index) {
                return BlocListener<CustomColorBloc, CustomColorState>(
                  listener: (context, state) {},
                  child: GestureDetector(
                    onTap: () => {
                      this._changeActiveBox(context, 100 + index % 4.0 * 10, colors[index % 4]),
                    },
                    child: Container(
                      color: colors[index % 4],
                      child: SizedBox(
                        width: 100 + index % 4.0 * 10,
                        height: 100 + index % 4.0 * 10,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 16);
              },
            ),
          ),
        ),
        Expanded(child: BlocBuilder<CustomColorBloc, CustomColorState>(
          builder: (context, state) {
            if (state is CustomColorStateInitial) {
              return Container(
                width: 50,
                height: 50,
                color: Colors.tealAccent,
              );
            } else if(state is CustomColorStateLoaded){
                return Container(
                  width: state.sheet[0],
                  color: state.sheet[1],
                );
            } else {
              return const SizedBox();
            }
          },
        )),
      ],
    );
  }
}
