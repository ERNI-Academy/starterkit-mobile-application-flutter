import 'package:reflectable/reflectable.dart';

class Reflection extends Reflectable {
  const Reflection() : super(declarationsCapability, metadataCapability, invokingCapability);
}
