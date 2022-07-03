
import 'package:easy_localization/easy_localization.dart';
import '../../translations/locale_keys.g.dart';

validateName(String value) {
  if (value.isEmpty) {
    return LocaleKeys.name_is_required.tr();
  }
  // else if (!regExp.hasMatch(value)) {
  //   return "Name must be a-z and A-Z";
  //}
  return null;
}
validate(String value) {
  if (value.isEmpty) {
    return LocaleKeys.required_field.tr();
  }
  return null;
}


validateNumber(String value, String message) {
  Pattern pattern = r'^[0-9]+$';
  if (value[0] != '5') {
    return "يجب ان يبدا رقم الجوال ب5";
  }
  if (value.length != 9) {
    return " يجب ان يكون 9 ارقام ";
  }
  RegExp regex = RegExp(pattern.toString());
  if (!regex.hasMatch(value)) return message;
  return null;
}

validatePassword(String value) {
  Pattern pattern = r'^.{6,}$';
  RegExp regex = RegExp(pattern.toString());
  if (!regex.hasMatch(value)) return LocaleKeys.password_is_required.tr();
  return null;
}

validateConfirmPassword(
    String value, String other) {
  Pattern pattern = r'^.{6,}$';
  RegExp regex = RegExp(pattern.toString());
  if (!regex.hasMatch(value)) return LocaleKeys.password_is_required.tr();
  return value == other ? null : LocaleKeys.confirm_password.tr();
}

validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern.toString());
  if (!regex.hasMatch(value)) return LocaleKeys.email_is_required.tr();
  return null;
}


validateMobile(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty) {
    return LocaleKeys.please_enter_phone.tr();
  }
  // else if (value.length != 10) {
  //   return "Mobile number must 11 digits";
 else if (!regExp.hasMatch(value)) {
    return "Mobile Number must be digits";
  }
  return null;
}
