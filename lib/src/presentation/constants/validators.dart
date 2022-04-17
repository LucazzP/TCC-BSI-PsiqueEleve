import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:psique_eleve/src/localization/app_localizations.dart';
import 'package:string_validator/string_validator.dart';

class Validators {
  static String? fullName(String? value) {
    value ??= '';
    final list = value.split(' ');

    if (value.isEmpty) {
      return S.current.emptyName;
    } else if (list.length == 1 || list.last.isEmpty) {
      return S.current.completeName;
    } else {
      return null;
    }
  }

  static String? cpf(String? value) {
    value ??= '';
    return CPFValidator.isValid(value) ? null : S.current.invalidCpf;
  }

  static String? cellphone(String? value) {
    value ??= '';
    if (value.isEmpty) {
      return S.current.emptyCellphone;
    }

    final split = value.replaceAll(RegExp(r'[ ()-]'), '');
    if (split.length >= 11) {
      return null;
    } else {
      return S.current.invalidCellphone;
    }
  }

  static String? password(String? password) {
    password ??= '';
    if (password.isEmpty) {
      return S.current.emptyPassword;
    }

    if (password.length < 6) {
      return S.current.shortPassword;
    }

    // final strength = estimatePasswordStrength(password);
    // if (strength < 0.3) {
    //   return S.current.weakPassword;
    // }

    return null;
  }

  static String? email(String? email) {
    email ??= '';
    if (email.isEmpty) {
      return S.current.emptyEmail;
    } else if (isEmail(email)) {
      return null;
    } else {
      return S.current.invalidEmail;
    }
  }

  static String? Function(String?) minLenght(int lenght) => (String? value) {
        value ??= '';
        if (value.isEmpty) {
          return S.current.emptyValue;
        } else if (value.length < lenght) {
          return S.current.shortValue;
        } else {
          return null;
        }
      };
}
