import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "Field cannot be empty";
  }

  if (val.length < min) {
    return "Must be at least $min characters long";
  }

  if (val.length > max) {
    return "Must not exceed $max characters";
  }

  if (type == "username") {
    final usernameRegex = RegExp(r'^[a-zA-Z0-9 ]+$');
    if (!usernameRegex.hasMatch(val)) {
      return "Invalid username. Only letters, numbers, and spaces are allowed.";
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "Invalid email address";
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "Invalid phone number";
    }
  }
}
