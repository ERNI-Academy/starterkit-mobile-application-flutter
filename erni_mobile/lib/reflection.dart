import 'package:reflectable/reflectable.dart';

const Reflector reflectable = Reflector();

class Reflector extends Reflectable {
  const Reflector() : super(declarationsCapability, metadataCapability, invokingCapability);
}
