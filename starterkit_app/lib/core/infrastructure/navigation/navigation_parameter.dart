import 'package:auto_route/auto_route.dart';

// Subclass of AutoRoute's QueryParam and PathParam to ignore @Target({TargetKind.parameter}) annotation

class NavigationQueryParam extends QueryParam {
  const NavigationQueryParam(String super.name);
}

class NavigationPathParam extends PathParam {
  const NavigationPathParam(String super.name);
}
