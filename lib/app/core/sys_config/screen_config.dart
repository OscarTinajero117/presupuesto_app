import 'package:flutter/services.dart';

void screenConfig() {
  /// Configuración de la orientación de la pantalla
  /// Solo permite la orientación vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  /// Configuración de la barra de estado
  /// Oculta la barra de estado
  /// y la barra de navegación
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [],
  );
}
