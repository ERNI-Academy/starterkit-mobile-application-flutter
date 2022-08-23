import 'package:erni_mobile/common/constants/deep_link_paths.dart';
import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/utils/converters/converter.dart';

class DeepLinkPathToRouteConverter implements Converter<String, String> {
  const DeepLinkPathToRouteConverter();

  @override
  String convert(String path) {
    switch (path) {
      case DeepLinkPaths.setInitialPassword:
        return RouteNames.setInitialPassword;
      case DeepLinkPaths.resetPassword:
        return RouteNames.resetPassword;
      default:
        return '';
    }
  }

  @override
  String convertBack(String route) {
    switch (route) {
      case RouteNames.setInitialPassword:
        return DeepLinkPaths.setInitialPassword;
      case RouteNames.resetPassword:
        return DeepLinkPaths.resetPassword;
      default:
        return '';
    }
  }
}
