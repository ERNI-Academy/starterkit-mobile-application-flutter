import 'package:flutter/material.dart';
import 'package:starterkit_app/core/presentation/views/child_view_mixin.dart';

import '../view_models/test_view_model.dart';

class TestChildView extends StatelessWidget with ChildViewMixin<TestViewModel> {
  const TestChildView(this.text, {super.key});

  final String text;

  @override
  Widget buildView(BuildContext context, TestViewModel viewModel) {
    return Text(text);
  }
}
