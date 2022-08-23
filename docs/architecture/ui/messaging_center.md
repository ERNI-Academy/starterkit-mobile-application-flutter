# Messaging Center

You can use [`MessagingCenter`](../../../erni_mobile/lib/core/services/messaging_center.dart) to pass messages from one class to another. This is a pub-sub notification style similar to iOS' [`NotificationCenter`](https://developer.apple.com/documentation/foundation/notificationcenter) and Xamarin.Forms' [`MessagingCenter`](https://docs.microsoft.com/en-us/dotnet/api/xamarin.forms.messagingcenter?view=xamarin-forms).

## Sending and Receiving Messages

Typically, `MessagingCenter` is used between view models.

Make sure that your receiver subscribes first to a specific channel:

```dart
class SideMenuViewModel {
    @override
    Future<void> onInitialize([String? parameter, Queries queries = const {}]) async {
        messaging.subscribe<String>(this, channel: 'ChannelName', action: (param) {
            // use `param`
        });
    }
}
```

You can send messages to a specific channel, passing an optional parameter:

```dart
class HomeViewModel {
    void sendMessage() {
        messaging.send('ChannelName', parameter: 'Some value');
    }
}
```

:warning: **<span style="color: orange">REMEMBER</span>**

Don't forget to unsubscribe the subscriber from the channel:

```dart
class SideMenuViewModel {
    @override
    Future<void> onInitialize([String? parameter, Queries queries = const {}]) async {
        messaging.subscribe<String>(this, channel: 'ChannelName', action: (param) {
            // use `param`
        });
    }

    @override
    void dispose() {
        messaging.unsubscribe(this, channel: 'ChannelName');
        super.dispose();
    }
}
```