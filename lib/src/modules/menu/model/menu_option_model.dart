import 'package:flutter/material.dart';

class MenuOptionModel {
  final String title;
  final VoidCallback? onTap;

  const MenuOptionModel({
    this.title = '',
    this.onTap,
  });
}
