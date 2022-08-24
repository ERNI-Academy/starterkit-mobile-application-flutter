// coverage:ignore-file

import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/resources/assets.gen.dart';
import 'package:erni_mobile_core/widgets.dart';
import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpacedColumn(
      spacing: 8,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.graphics.icErniLogoWhiteText.image(color: Colors.white),
        Text(
          Il8n.current.appTitle,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
