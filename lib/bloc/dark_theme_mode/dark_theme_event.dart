abstract class DarkThemeEvents {}

class DarkModeToggleAndPreference extends DarkThemeEvents {
  bool? darkModeToggle;
  DarkModeToggleAndPreference({required this.darkModeToggle});
}

class GetDarkModePreference extends DarkThemeEvents {}
