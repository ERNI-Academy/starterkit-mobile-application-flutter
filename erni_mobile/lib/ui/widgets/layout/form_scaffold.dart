// coverage:ignore-file

import 'package:erni_mobile/ui/view_models/form_view_model.dart';
import 'package:erni_mobile/ui/widgets/layout/form_body.dart';
import 'package:erni_mobile/ui/widgets/layout/form_button.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_blueprint_core/mvvm.dart';

class FormScaffold<T extends FormViewModel> extends StatelessWidget with ChildViewMixin<T> {
  FormScaffold({
    required this.title,
    required this.submitLabel,
    required this.fields,
    Key? key,
  }) : super(key: key);

  final FocusNode _focusNode = FocusNode();

  final String title;
  final String submitLabel;
  final List<Widget> fields;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(title),
        backgroundColor: context.materialTheme.colorScheme.surface,
        foregroundColor: context.materialTheme.colorScheme.onSurface,
      ),
      backgroundColor: context.materialTheme.colorScheme.surface,
      body: AdaptiveStatusBar(
        referenceColor: context.materialTheme.colorScheme.surface,
        child: Center(
          child: Container(
            color: context.materialTheme.colorScheme.background,
            child: StickyFooterScrollView.explicit(
              footer: FormButton<T>(submitLabel: submitLabel, formBodyFocusNode: _focusNode),
              children: [
                Focus(
                  focusNode: _focusNode,
                  child: _FormBodyContainer<T>(
                    submitLabel: submitLabel,
                    children: fields,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FormBodyContainer<T extends FormViewModel> extends StatelessWidget with ChildViewMixin<T> {
  _FormBodyContainer({
    required this.submitLabel,
    required this.children,
    Key? key,
  }) : super(key: key);

  final String submitLabel;
  final List<Widget> children;

  @override
  Widget buildView(BuildContext context) {
    return Container(
      color: context.materialTheme.colorScheme.surface,
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 24,
        children: [
          Padding(
            padding: context.appTheme.edgeInsets.containerPadding,
            child: FormBody<T>(children: children),
          ),
        ],
      ),
    );
  }
}
