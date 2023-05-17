// ignore_for_file: unused_import

@GlobalQuantifyCapability(r'\.\w+ViewModel$', navigatable)
import 'package:reflectable/reflectable.dart';
import 'package:starterkit_app/features/posts/presentation/view_models/post_details_view_model.dart'; // TODO(dustincatap): Check if there is a way to avoid this import when using `reflectable`

const DefaultReflector navigatable = DefaultReflector();

class DefaultReflector extends Reflectable {
  const DefaultReflector() : super(declarationsCapability, metadataCapability, invokingCapability);
}
