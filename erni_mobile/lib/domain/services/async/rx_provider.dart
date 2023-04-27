import 'package:rxdart/rxdart.dart';

abstract class RxProvider {
  BehaviorSubject<T> createSeededSubject<T>(T initialValue, {bool sync = false});
}
