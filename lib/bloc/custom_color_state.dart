import 'package:equatable/equatable.dart';

abstract class CustomColorState extends Equatable {
  const CustomColorState();
}
class CustomColorStateInitial extends CustomColorState {
  const CustomColorStateInitial();

  @override
  List<Object> get props => [];
}

class CustomColorStateLoaded extends CustomColorState {

  final List sheet;
  const CustomColorStateLoaded(this.sheet);

  @override
  List<Object> get props => [sheet];
}