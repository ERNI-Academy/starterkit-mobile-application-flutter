import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/views/view_mixin.dart';

import '../view_models/test_view_model.dart';
import 'test_child_view.dart';

@RoutePage()
class TestView extends StatelessWidget with ViewMixin<TestViewModel> {
  const TestView(this.text, {super.key});

  final String text;

  @override
  Widget buildView(BuildContext context, TestViewModel viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: TestChildView(text),
      ),
    );
  }
}
