import 'package:flutter/material.dart';

class MenuOptionModel {
  final String title;
  final VoidCallback? onTap;
  final IconData? icon;

  const MenuOptionModel({
    this.title = '',
    this.onTap,
    this.icon,
  });
}
