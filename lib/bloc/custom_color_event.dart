import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class CustomColorEvent extends Equatable {
  const CustomColorEvent();
}

class GetBigSheet extends CustomColorEvent{
  final double width;
  final Color color;
  const GetBigSheet(this.width, this.color);

  @override
  List<Object> get props => [width];

}