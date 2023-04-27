import 'package:reflectable/reflectable.dart';

const DefaultReflector navigatable = DefaultReflector();

class DefaultReflector extends Reflectable {
  const DefaultReflector() : super(declarationsCapability, metadataCapability, invokingCapability);
}
