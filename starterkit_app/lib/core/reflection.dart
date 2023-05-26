import 'package:reflectable/reflectable.dart';

const Reflectable navigatable = DefaultReflector();

class DefaultReflector extends Reflectable {
  const DefaultReflector() : super(declarationsCapability, metadataCapability, invokingCapability);
}
