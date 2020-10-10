part of 'theme_bloc.dart';

// Delete abstract
class ThemeState extends Equatable {
  // 1. Add this
  final ThemeData themeData;

  // 2. Assign it to constructor
  const ThemeState(this.themeData);

  @override
  List<Object> get props => [themeData];
}
