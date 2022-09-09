// coverage:ignore-file

import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/view_models/settings/account_settings_view_model.dart';
import 'package:erni_mobile/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class AccountSettingsView extends StatelessWidget with ViewMixin<AccountSettingsViewModel> {
  const AccountSettingsView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, AccountSettingsViewModel viewModel) {
    return Column(
      children: [
        ListTile(
          title: Text(Il8n.of(context).settingsChangePassword),
        ),
        ListTile(
          title: Text(
            Il8n.of(context).settingsDeleteAccount,
            style: TextStyle(color: context.materialTheme.colorScheme.error),
          ),
        ),
      ],
    );
  }
}
