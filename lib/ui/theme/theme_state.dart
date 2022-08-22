import 'package:equatable/equatable.dart';
import 'package:shopping/ui/theme/themes.dart';

class ThemeState extends Equatable {
  const ThemeState({this.theme = const DarkTheme()});

  final AppTheme theme;
  bool get isDarkTheme => theme.isDarkMode;

  ThemeState copyWith({
    AppTheme Function()? theme,
  }) {
    return ThemeState(
      theme: theme?.call() ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [theme];
}
