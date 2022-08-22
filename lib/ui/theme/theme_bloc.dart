import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping/ui/theme/theme_event.dart';
import 'package:shopping/ui/theme/theme_state.dart';
import 'package:shopping/ui/theme/themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState()) {
    on<ToggleThemeEvent>(_toggleTheme);
  }

  FutureOr<void> _toggleTheme(
    ToggleThemeEvent event,
    Emitter<ThemeState> emit,
  ) {
    emit(
      state.copyWith(
        theme: () => state.isDarkTheme ? const LightTheme() : const DarkTheme(),
      ),
    );
  }
}
