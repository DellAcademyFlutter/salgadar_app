import 'dart:math';

/// Classe com metodos uteis da Matematica.
class MathUtils {
  /// Arredonda [number] para [decimalPlaces] casas decimais.
  static round({double number, int decimalPlaces}) {
    return (number * pow(10, decimalPlaces)).round() / pow(10, decimalPlaces);
  }
}
