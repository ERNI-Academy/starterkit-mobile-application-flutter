// coverage:ignore-file

import 'package:erni_mobile/ui/resources/assets.gen.dart';
import 'package:erni_mobile/ui/view_models/form_view_model.dart';
import 'package:erni_mobile/ui/widgets/layout/form_body.dart';
import 'package:erni_mobile/ui/widgets/layout/form_button.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_core/mvvm.dart';

class BanneredFormScaffold<T extends FormViewModel> extends StatelessWidget with ChildViewMixin<T> {
  BanneredFormScaffold({
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
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: context.materialTheme.colorScheme.primary,
      body: AdaptiveStatusBar(
        referenceColor: context.materialTheme.colorScheme.primary,
        child: MediaQuery.removePadding(
          context: context,
          child: SafeArea(
            bottom: false,
            child: Center(
              child: Container(
                color: context.materialTheme.colorScheme.primary,
                child: StickyFooterScrollView.explicit(
                  backgroundColor: context.materialTheme.colorScheme.background,
                  footer: FormButton<T>(submitLabel: submitLabel, formBodyFocusNode: _focusNode),
                  children: [
                    Container(
                      color: context.materialTheme.colorScheme.primary,
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 64),
                            child: AppBanner(),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Assets.graphics.imIllustration.image(),
                          ),
                        ],
                      ),
                    ),
                    Focus(
                      focusNode: _focusNode,
                      child: _FormBodyContainer<T>(
                        title: title,
                        submitLabel: submitLabel,
                        children: fields,
                      ),
                    ),
                  ],
                ),
              ),
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
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;
  final String submitLabel;
  final List<Widget> children;

  @override
  Widget buildView(BuildContext context) {
    return Container(
      color: context.materialTheme.colorScheme.background,
      child: SpacedColumn(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 24,
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.appTheme.edgeInsets.containerPadding.top),
            child: Align(
              child: Text(
                title,
                style: context.materialTheme.textTheme.headlineSmall,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: context.appTheme.edgeInsets.containerPadding.left,
              right: context.appTheme.edgeInsets.containerPadding.right,
              bottom: context.appTheme.edgeInsets.containerPadding.bottom,
            ),
            child: FormBody<T>(children: children),
          ),
        ],
      ),
    );
  }
}
