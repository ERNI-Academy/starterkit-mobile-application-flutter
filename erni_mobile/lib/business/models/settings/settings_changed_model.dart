import 'package:meta/meta.dart';

@immutable
class SettingsChangedModel {
  const SettingsChangedModel(this.key, this.value);

  final String key;
  final Object? value;
}
