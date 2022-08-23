// coverage:ignore-file

import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/view_models/authentication/forgot_password_view_model.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_blueprint_core/mvvm.dart';
import 'package:injectable/injectable.dart';
import 'package:validation_notifier/validation_notifier.dart';

@Named(RouteNames.forgotPassword)
@Injectable(as: Widget)
class ForgotPasswordView extends StatelessWidget with ViewMixin<ForgotPasswordViewModel> {
  ForgotPasswordView() : super(key: const Key(RouteNames.forgotPassword));

  @override
  Widget buildView(BuildContext context) {
    return BanneredFormScaffold<ForgotPasswordViewModel>(
      title: Il8n.of(context).forgotPasswordTitle,
      submitLabel: Il8n.of(context).forgotPasswordButtonLabel,
      fields: [
        Text(Il8n.of(context).forgotPasswordHintLabel),
        ValueListenableBuilder<ValidationResult<String>>(
          valueListenable: viewModel.email,
          builder: (context, email, child) {
            return AppTextFormField(
              onChanged: viewModel.email.update,
              autofillHints: const [AutofillHints.email],
              textInputType: TextInputType.emailAddress,
              labelText: Il8n.of(context).forgotPasswordEmailLabel,
              hasError: email.hasError,
            );
          },
        ),
      ],
    );
  }
}
