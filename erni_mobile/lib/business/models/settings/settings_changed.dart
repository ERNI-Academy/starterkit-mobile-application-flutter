import 'package:meta/meta.dart';

@immutable
class SettingsChanged {
  const SettingsChanged(this.key, this.value);

  final String key;
  final Object? value;
}
