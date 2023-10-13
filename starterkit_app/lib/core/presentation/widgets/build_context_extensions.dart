import 'package:flutter/widgets.dart';
import 'package:starterkit_app/common/localization/generated/l10n.dart';

extension BuildContextExtension on BuildContext {
  Il8n get il8n => Il8n.of(this);
}
