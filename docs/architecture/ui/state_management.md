# State Management

The project's state management will be using the **MVVM (Model-View-View Model)** design pattern.

## ValueNotifiers and ValueListenableBuilders
Currently, there are [multiple state management packages](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options).

Although not mentioned in Flutter's recommended approaches, [`ValueNotifier`](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html) combined with [`ValueListenableBuilder`](https://api.flutter.dev/flutter/widgets/ValueListenableBuilder-class.html) proved to be much simpler and is readily available out-of-the-box. This approach is very simple and allows us to update only the needed part of the UI.

Given the following classes, calling `HomeViewModel.increment()` will notify our view to update the `Text` widget:

```dart
class HomeViewModel extends ViewModel {
  final ValueNotifier<int> count = ValueNotifier(0);

  void increment() => count.value++;
}

class HomeView extends StatelessWidget with ViewMixin<HomeViewModel> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ValueListenableBuilder<int>(
        valueListenable: viewModel.count,
        builder: (context, count, child) {
          return Text('Count value: $count');
        },
      ),
    );
  }
}
```

:bulb: **<span style="color: green">TIP</span>**

Use the snippet shortcut `valb` to a `ValueListenableBuilder` widget.