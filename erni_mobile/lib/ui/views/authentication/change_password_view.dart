// coverage:ignore-file

import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/view_models/authentication/change_password_view_model.dart';
import 'package:erni_mobile/ui/views/authentication/set_password_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_core/mvvm.dart';
import 'package:injectable/injectable.dart';
import 'package:validation_notifier/validation_notifier.dart';

@Named(RouteNames.changePassword)
@Injectable(as: Widget)
class ChangePasswordView extends StatelessWidget with ViewMixin<ChangePasswordViewModel> {
  ChangePasswordView() : super(key: const Key(RouteNames.changePassword));

  @override
  Widget buildView(BuildContext context) {
    return SetPasswordView<ChangePasswordViewModel>(
      title: Il8n.of(context).changePasswordTitle,
      submitLabel: Il8n.of(context).changePasswordButtonLabel,
      hasBanner: false,
      additionalField: ValueListenableBuilder<ValidationResult<String>>(
        valueListenable: viewModel.oldPassword,
        builder: (context, oldPassword, child) {
          return AppTextFormField(
            onChanged: viewModel.oldPassword.update,
            labelText: Il8n.of(context).currentPasswordLabel,
            autofillHints: const [AutofillHints.password],
            hasError: oldPassword.hasError,
            isPassword: true,
          );
        },
      ),
    );
  }
}
