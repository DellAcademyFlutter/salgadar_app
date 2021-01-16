import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:salgadar_app/app/shared/utils/regexps.dart';

class Validator {
  static var emailValidatorRegExp = RegExp(email_regexp);
  static var dateValidatorRegExp = RegExp(birthday_regexp);

  static final dateMaskFormatter = MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});

  /// Valida um email submetido.
  static bool validateEmail(String submittedValue) =>
      (emailValidatorRegExp.hasMatch(submittedValue));

  /// Valida uma data de aniversario submetido.
  static bool validateDate(String submittedValue) =>
      (dateValidatorRegExp.hasMatch(submittedValue));
}
