import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());
  void toggleTheme() {
    if (state is ThemeLight) {
      emit(ThemeDark());
    } else {
      emit(ThemeLight());
    }
  }

  void setLightTheme() => emit(ThemeLight());
  void setDarkTheme() => emit(ThemeDark());
}
