import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sisi_iot_app/ui/common/color.dart';
import 'package:sisi_iot_app/ui/common/common_label.dart';
import 'package:sisi_iot_app/ui/common/common_style_text.dart';

ThemeData lightThemeData(BuildContext context) {
  return ThemeData.light().copyWith(
    primaryColor: CommonColor.colorPrimary,
    // #C1A9F1
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: CommonColor.colorPrimary,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      titleTextStyle: TitleStyle(color: Colors.white),
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black87, // Texto oscuro para un fondo claro
          fontFamily: CommonLabel.letterWalkwayBold,
        ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(MaterialState.selected)) {
            return CommonColor.colorPrimary;
          }
          return Colors.grey[400]; // Gris para no seleccionado
        },
      ),
    ),
    cardTheme: const CardTheme(color: Color(0xFFF9F9F9)),
    // Fondo claro para tarjetas
    dividerTheme: DividerThemeData(color: Colors.grey[350]),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.selected)) {
            return CommonColor.colorPrimary; // Color principal para el switch activo
          }
          return Colors.grey; // Gris para el switch no activo
        },
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: CommonColor.colorPrimary).copyWith(
      background: Colors.white,
      primary: CommonColor.colorPrimary,
      secondary: const Color(0xFF6A4D8E),
      // Púrpura oscuro como color secundario
      error: Colors.red,
      onPrimary: Colors.white,
      // Texto en botones de color principal
      surfaceTint: Colors.grey[50]!,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: CommonColor.colorPrimary,
      unselectedItemColor: Colors.grey[600],
      // Menos énfasis en iconos no seleccionados
      selectedIconTheme: IconThemeData(color: CommonColor.colorPrimary),
      showUnselectedLabels: true,
    ),
  );
}

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: CommonColor.colorPrimary,
    // #C1A9F1
    scaffoldBackgroundColor: const Color(0xFF03182B),
    // Fondo oscuro profundo
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      color: Color(0xFF03182B),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      titleTextStyle:
          TitleStyle(color: CommonColor.colorPrimary), // Título con el color principal
    ),
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white70, // Texto claro para fondo oscuro
          fontFamily: CommonLabel.letterWalkwayBold,
        ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return CommonColor.colorPrimary;
          }
          return Colors.grey[700]; // Gris oscuro para no seleccionado
        },
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return CommonColor.colorPrimary; // El lila para el switch activo
          }
          return Colors.grey; // Gris para el switch no activo
        },
      ),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Color(0xFF6A4D8E); // Púrpura oscuro para la pista seleccionada
          }
          return Colors.grey[800]; // Pista gris oscuro
        },
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: CommonColor.colorPrimary,
      brightness: Brightness.dark,
    ).copyWith(
      primary: CommonColor.colorPrimary,
      // Color principal en el tema oscuro
      secondary: const Color(0xFF6A4D8E),
      // Púrpura oscuro como color secundario
      background: const Color(0xFF03182B),
      // Fondo oscuro
      onPrimary: Colors.white,
      // Texto blanco en botones del color principal
      error: Colors.red,
      surfaceTint: Colors.grey[800],
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF03182B),
      // Fondo oscuro para la barra inferior
      selectedItemColor: CommonColor.colorPrimary,
      unselectedItemColor: Colors.white70.withOpacity(0.6),
      // Blanco claro para no seleccionados
      selectedIconTheme: const IconThemeData(color: CommonColor.colorPrimary),
      showUnselectedLabels: true,
    ),
  );
}
