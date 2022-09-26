// coverage:ignore-file

import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/view_models/settings/settings_view_model.dart';
import 'package:erni_mobile/ui/views/settings/update_app_settings_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class SettingsView extends StatelessWidget with ViewMixin<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, SettingsViewModel viewModel) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(subtitle: _ListSectionTitle(Il8n.of(context).settingsAppSectionTitle)),
          const UpdateAppSettingsView(),
        ],
      ),
    );
  }
}

class _ListSectionTitle extends StatelessWidget {
  const _ListSectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.materialTheme.textTheme.caption,
    );
  }
}
