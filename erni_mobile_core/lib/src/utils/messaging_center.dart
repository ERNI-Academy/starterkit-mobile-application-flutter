// coverage:ignore-file
// ignore_for_file: avoid-dynamic

import 'package:injectable/injectable.dart';

final _map = <String, Map<Object, dynamic>>{};
final _messages = <String, List<Object>>{};

abstract class MessagingCenter {
  void subscribe<T extends Object>(Object subscriber, {required String channel, required void Function(T?) action});

  void unsubscribe(Object subscriber, {required String channel});

  void send<T extends Object>({required String channel, T? parameter});

  List<T> messagesOf<T extends Object>({required String channel});
}

@LazySingleton(as: MessagingCenter)
class MessagingCenterImpl implements MessagingCenter {
  @override
  void subscribe<T extends Object>(Object subscriber, {required String channel, required void Function(T?) action}) {
    assert(channel.isNotEmpty);

    if (!_map.containsKey(channel)) {
      _map[channel] = <Object, dynamic>{};
    }

    final subscribers = _map[channel]!;
    subscribers.remove(subscriber);
    subscribers.putIfAbsent(subscriber, () => action) as void Function(T?);
  }

  @override
  void send<T extends Object>({required String channel, T? parameter}) {
    assert(channel.isNotEmpty);

    final actions = (_map[channel]?.values ?? <void Function(T?)>[]).cast<void Function(T?)>();

    if (_map.containsKey(channel)) {
      for (final action in actions) {
        action(parameter);
      }
    }

    if (!_messages.containsKey(channel)) {
      _messages[channel] = [];
    }

    if (parameter != null) {
      _messages[channel]!.add(parameter);
    }
  }

  @override
  void unsubscribe(Object subscriber, {required String channel}) {
    if (_map.containsKey(channel)) {
      final subscribers = _map[channel]!;
      subscribers.remove(subscriber);

      if (subscribers.isEmpty) {
        _map.remove(channel);
        _messages.remove(channel);
      }
    }
  }

  @override
  List<T> messagesOf<T extends Object>({required String channel}) {
    if (_messages.containsKey(channel)) {
      return List.unmodifiable(_messages[channel]!.cast<T>());
    }

    return const [];
  }
}
