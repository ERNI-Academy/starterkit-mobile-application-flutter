import 'package:erni_mobile/common/constants/widget_keys.dart';
import 'package:erni_mobile/domain/services/ui/build_context_provider.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BuildContextProvider)
class BuildContextProviderImpl implements BuildContextProvider {
  @override
  BuildContext get context {
    final context = WidgetKeys.navigatorKey.currentState?.overlay?.context;

    if (context == null) {
      throw StateError('BuildContext is null');
    }

    return context;
  }
}
