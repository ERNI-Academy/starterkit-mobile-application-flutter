import 'package:erni_mobile/domain/services/async/delay_provider.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DelayProvider)
class DelayProviderImpl implements DelayProvider {
  @override
  Future<void> delay(int milliseconds) => Future.delayed(Duration(milliseconds: milliseconds));
}
