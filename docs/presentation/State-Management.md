## ValueNotifiers, ValueListenable and ValueListenableBuilders

Currently, there are [multiple state management packages](https://docs.flutter.dev/development/data-and-backend/state-mgmt/options).

Although not mentioned in Flutter's recommended approaches, [`ValueListenable`](https://api.flutter.dev/flutter/foundation/ValueListenable-class.html)/[`ValueNotifier`](https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html)combined with [`ValueListenableBuilder`](https://api.flutter.dev/flutter/widgets/ValueListenableBuilder-class.html) proved to be much simpler and is readily available out-of-the-box. This approach is very simple and allows us to update only the needed part of the UI.

Given the following view model:

```dart
class HomeViewModel extends ViewModel {
  final ValueNotifier<int> _count = ValueNotifier(0);

  ValueListenable<int> get count => _count;

  void increment() => _count.value++;
}

```

And your view:

```dart
class HomeView extends StatelessWidget with ViewMixin<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget buildView(BuildContext context, HomeViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ValueListenableBuilder<int>(
        valueListenable: viewModel.count,
        builder: (context, count, child) {
          return Text('Count value: $count');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

Calling `HomeViewModel.increment()` will notify our view to update the `Text` widget.

:bulb: **<span style="color: green">TIP</span>**

- You only expose what is needed. We used `ValueListenable` instead of `ValueNotifier` since the former allow you to read only the value and the latter allows both reading/updating the value. Mutation should be encapsulated inside the view model.
- You can target specific widget in the tree that needs to be updated. You just wrap it with `ValueListenableBuilder`.
- Use a private `ValueNotifier` and expose it as a `ValueListenable` property. This will prevent other classes from updating the value.
- Use the snippet shortcut `valn` to a `ValueListenable/ValueNotifier` combination.
- Use the snippet shortcut `valb` to a `ValueListenableBuilder` widget.