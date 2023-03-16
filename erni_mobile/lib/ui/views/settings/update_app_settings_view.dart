// coverage:ignore-file

import 'package:erni_mobile/business/models/settings/language.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/view_models/settings/update_app_settings_view_model.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class UpdateAppSettingsView extends StatelessWidget with ViewMixin<UpdateAppSettingsViewModel> {
  const UpdateAppSettingsView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context, UpdateAppSettingsViewModel viewModel) {
    return Column(
      children: [
        ListTile(
          title: Text(Il8n.of(context).settingsLanguage),
          subtitle: ValueListenableBuilder<Language>(
            valueListenable: viewModel.currentLanguage,
            builder: (context, currentLocale, child) {
              return Text(currentLocale.languageCode.name.toUpperCase());
            },
          ),
          onTap: viewModel.onToggleLanguage,
        ),
        ValueListenableBuilder<ThemeMode>(
          valueListenable: viewModel.currentTheme,
          builder: (context, currentTheme, child) {
            final isDarkTheme = currentTheme == ThemeMode.dark;

            return SwitchListTile(
              title: Text(Il8n.of(context).settingsDarkTheme),
              value: isDarkTheme,
              onChanged: (v) => viewModel.onToggleDarkTheme,
            );
          },
        ),
      ],
    );
  }
}
