import 'package:easy_mask/easy_mask.dart';
import 'package:psique_eleve/src/presentation/constants/masks.dart';

extension StringExtensions on String {
  String get capitalizeFirstLetter =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String get capitalizeAllFirstLetters =>
      replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.capitalizeFirstLetter).join(" ");

  String withEllipse({int maxLength = 78, bool keepExt = true}) => length > maxLength
      ? '${substring(0, maxLength - 3)}...'
          '${keepExt ? ' ' + substring(length - 4, length) : ''}'
      : this;

  String get withCpfMask => MagicMask.buildMask(kCpfMask).getMaskedString(this);

  String get withZipCodeMask => MagicMask.buildMask(kZipCodeMask).getMaskedString(this);

  String get withPhoneMask => MagicMask.buildMask(kPhoneMask).getMaskedString(this);

  String get removeAllMasks => replaceAll(RegExp(r'[\(\)\.\s-]+'), '');
}

extension StringNullableExtensions on String? {
  bool get isNotNullAndNotEmpty {
    final string = this;
    return string != null && string.isNotEmpty;
  }

  String get getNotNullValue => this ?? '';
}
