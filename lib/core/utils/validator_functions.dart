import 'package:country_picker/country_picker.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import '../constants/app_keys.dart';


abstract class Validator {
  static String? validateEmail(String? val) {
    final RegExp emailRegex = RegExp(AppKeys.emailRegex);
    if (val == null || val.trim().isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(val)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val) {
    final RegExp passwordRegex = RegExp(AppKeys.passwordRegex);
    if (val == null || val.isEmpty) {
      return 'Password cannot be empty';
    } else if (!passwordRegex.hasMatch(val)) {
      return 'Enter a valid password';
    } else {
      return null;
    }
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'Password cannot be empty';
    } else if (val != password) {
      return 'Confirm password must match the password';
    } else {
      return null;
    }
  }

  static String? validateName(String? val) {
    if (val == null || val.isEmpty) {
      return 'Name cannot be empty';
    } else {
      return null;
    }
  }

  //_________Normal validatePhoneNumber ______
  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

    final phone = val.trim();

    if (!RegExp(r'^\d+$').hasMatch(phone)) {
      return 'Phone number must contain digits only';
    }

    if (phone.length < 8 || phone.length > 15) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  //________________________________________________________________

  static String? validateInternationalPhoneNumber(
    String? val,
    Country? country,
  ) {
   
    if (val == null || val.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

   
    final basicValidation = validatePhoneNumber(val);
    if (basicValidation != null) {
      return basicValidation;
    }

  
    if (country == null) {
      return 'Please select a country';
    }

  
    try {
      final phone = PhoneNumber.parse(
        val,
        destinationCountry: IsoCode.values.firstWhere(
          (e) => e.name == country.countryCode,
        ),
      );

      if (!phone.isValid()) {
        return 'Enter a valid phone number';
      }
    } catch (_) {
      return 'Enter a valid phone number';
    }

    return null;
  }

  static String? validateCode(String? val) {
    if (val == null || val.isEmpty) {
      return 'Code cannot be empty';
    } else if (val.length < 6) {
      return 'Code should be at least 6 digits';
    } else {
      return null;
    }
  }
}
