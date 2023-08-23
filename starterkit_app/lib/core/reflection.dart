import 'package:reflectable/reflectable.dart';

const Reflectable navigatable = Reflection();

class Reflection extends Reflectable {
  const Reflection() : super(declarationsCapability, metadataCapability, invokingCapability);
}
