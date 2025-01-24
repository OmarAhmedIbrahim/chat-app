class Validator {
  static String? filledValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'This field is empty ';
    }
  }

  // Used static so that we don't need to create an object of the class
  static String? emailValidator(String? value) {
    // if the value is null the condition will return true
    if (value?.isEmpty ?? true) {
      return 'This field is empty ';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegex.hasMatch(value!)) {
      return 'Please enter a valid email address.';
    }
    return null; // Input is valid
  }

  static String? passwordValidator(String? value) {
    if (value?.isEmpty ?? true) {
      return 'This field is empty ';
    }
    final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    if (!passwordRegex.hasMatch(value!)) {
      return 'Weak Password it must be 8+ characters, with uppercase, lowercase, number, and special character.';
    }
    return null; // Input is valid
  }

  static String? confirmPasswordValidator(String? value, String password) {
    if (value?.isEmpty ?? true) {
      return 'This field is empty ';
    }
    if (value == password) {
      return null;
    } else {
      return 'Passwords do not match';
    }
  }
}
