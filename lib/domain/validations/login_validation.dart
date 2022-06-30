import 'package:intl/intl.dart';

import '../models/users_datas.dart';

class ValidationTextField {
  static String? emailValidations(String? email,
      {List<GetUsersDetails>? details}) {
    const regexp = r'\S+@\S+\.\S+';
    if (email == null || email.isEmpty) {
      return "Enter the value to the field";
    } else if (!RegExp(regexp).hasMatch(email)) {
      return "Enter the valid email Address";
    } else if (details != null) {
      if (!isEmailisHere(email, details)) {
        return "The Email is already Taken";
      }
      return null;
    } else {
      return null;
    }
  }

  static String? passwordValidation(String? password, {String? cheakValue}) {
    if (password == null || password.isEmpty) {
      return "Enter the value to the field";
    } else if (password.length <= 5) {
      return "Password must be minimum 6 character";
    } else if (cheakValue != null) {
      if (password != cheakValue) {
        return 'Password Did not match';
      }
      return null;
    } else {
      return null;
    }
  }

  static String? nameValidation(String? password) {
    if (password == null || password.isEmpty) {
      return "Enter the value to the field";
    } else if (password.length <= 5) {
      return "Name must be minimum 6 character";
    } else {
      return null;
    }
  }

  static String? phoneNoValidation(String? value,
      {List<GetUsersDetails>? details}) {
    const regex = r"^(?:[+0]9)?[0-9]{10}$";
    if (value == null || value.isEmpty) {
      return "Enter the value to the field";
    } else if (!RegExp(regex).hasMatch(value)) {
      return "Enter the valid mobile No.";
    } else if (details != null) {
      if (!isPhoneNoisHere(value, details)) {
        return 'The mobile no is already taken';
      }
      return null;
    } else {
      return null;
    }
  }

  static bool isEmailisHere(
      String cheakingValue, List<GetUsersDetails> cheakingListValue) {
    for (var i = 0; i < cheakingListValue.length; i++) {
      if (cheakingValue == cheakingListValue[i].email) {
        return false;
      } else {
        continue;
      }
    }
    return true;
  }

  static bool isPhoneNoisHere(
      String cheakingValue, List<GetUsersDetails> cheakingListValue) {
    for (var i = 0; i < cheakingListValue.length; i++) {
      if (cheakingValue == cheakingListValue[i].phone.toString()) {
        return false;
      } else {
        continue;
      }
    }
    return true;
  }

  static String? locationValidation(String? password,
      {String? cheakValue, int? value}) {
    if (password == null || password.isEmpty) {
      return "Enter the value to the field";
    } else if (password.length <= value!) {
      return "This field must be minimum $value character";
    } else {
      return null;
    }
  }

  static String? dateValidation(String? password,
      {String? cheakValue, int? value}) {
    if (password == null || password.isEmpty) {
      return "Enter the value to the field";
    } else {
      return null;
    }
  }
}
