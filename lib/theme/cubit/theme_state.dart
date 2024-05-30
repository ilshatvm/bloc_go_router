part of 'theme_cubit.dart';

final class ThemeState extends Equatable {
  const ThemeState({required this.theme});

  final ThemeData theme;

  @override
  List<Object> get props => [theme];
}
