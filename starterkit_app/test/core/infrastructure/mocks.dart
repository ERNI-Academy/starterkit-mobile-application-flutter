import 'package:mockito/annotations.dart';
import 'package:starterkit_app/core/infrastructure/logging/logger.dart';
import 'package:starterkit_app/core/infrastructure/navigation/navigation_service.dart';

@GenerateNiceMocks([
  MockSpec<Logger>(),
  MockSpec<NavigationService>(),
])
void main() {}
