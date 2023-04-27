import 'package:erni_mobile/domain/services/async/rx_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@LazySingleton(as: RxProvider)
class RxProviderImpl implements RxProvider {
  @override
  BehaviorSubject<T> createSeededSubject<T>(T initialValue, {bool sync = false}) {
    return BehaviorSubject<T>.seeded(initialValue, sync: sync);
  }
}
