// coverage:ignore-file

import 'package:erni_mobile/ui/widgets/extensions/theme_extensions.dart';
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({this.url, Key? key}) : super(key: key);

  final String? url;

  @override
  Widget build(BuildContext context) {
    final nullableUrl = url;

    return CircleAvatar(
      radius: 24,
      foregroundColor: context.materialTheme.colorScheme.primary,
      backgroundColor: context.materialTheme.colorScheme.primary.withOpacity(0.2),
      foregroundImage: nullableUrl != null ? NetworkImage(nullableUrl) : null,
      child: const Icon(Icons.person),
    );
  }
}
