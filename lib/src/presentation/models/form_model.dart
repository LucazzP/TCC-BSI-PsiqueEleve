import 'package:equatable/equatable.dart';

class FormModel extends Equatable {
  final String value;
  final String? error;
  final String? Function(String? value) validator;

  const FormModel({
    this.value = '',
    this.error,
    required this.validator,
  });

  FormModel copyWith({
    String? value,
    String? error,
    String? Function(String? value)? validator,
    bool resetError = false,
  }) {
    return FormModel(
      value: value ?? this.value,
      error: resetError ? error : error ?? this.error,
      validator: validator ?? this.validator,
    );
  }

  @override
  List<Object?> get props => [value, error];
}
