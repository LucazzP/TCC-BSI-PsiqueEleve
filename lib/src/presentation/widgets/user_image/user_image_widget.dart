import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:psique_eleve/src/presentation/styles/app_color_scheme.dart';
import 'package:psique_eleve/src/presentation/styles/app_text_theme.dart';
import 'package:psique_eleve/src/presentation/widgets/ternary/ternary_widget.dart';

class UserImageWidget extends StatelessWidget {
  final String imageUrl;
  final String fullName;
  final VoidCallback? onEdit;

  const UserImageWidget({
    Key? key,
    this.imageUrl = '',
    required this.fullName,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: imageUrl.isNotEmpty ? CachedNetworkImageProvider(imageUrl) : null,
      radius: 65,
      backgroundColor: AppColorScheme.primaryDark,
      child: Stack(
        alignment: Alignment.center,
        children: [
          TernaryWidget(
            value: imageUrl.isEmpty,
            trueWidget: _nameInitialsImage(fullName),
            useAnimation: false,
          ),
          if (onEdit != null)
            Transform.translate(
              offset: const Offset(10, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColorScheme.primarySwatch[300],
                    shape: BoxShape.circle,
                  ),
                  height: 40,
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: onEdit,
                    iconSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _nameInitialsImage(String fullName) {
    final splitted = fullName.toUpperCase().split(' ');
    if (splitted.length < 2 || splitted.last.isEmpty) return Container();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          splitted.first.substring(0, 1) + splitted.last.substring(0, 1),
          style: AppTextTheme.textTheme.headline6?.copyWith(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}
