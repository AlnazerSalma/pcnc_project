import 'package:pcnc/core/extension/string_ext.dart';

class Validator {
  static String? validateUsernameOrEmail(String? value, String isValidEmail) {
    if (value == null || value.trim().isEmpty) {
      return isValidEmail;
    }
    return null;
  }

  static String? validateEmail(String? value, String invalidEmailMessage) {
    if (value == null || value.trim().isEmpty || !(value.isValidEmail)) {
      return invalidEmailMessage;
    }
    return null;
  }

  static String? validatePassword(String? value, String invalidPasswordMessage, int minLength) {
    if (value == null || value.trim().length < minLength) {
      return invalidPasswordMessage;
    }
    return null;
  }

  static String? validateComplexPassword(String? value, String invalidPasswordMessage) {
    if (value == null || !(value.isValidPassword)) {
      return invalidPasswordMessage;
    }
    return null;
  }
}
