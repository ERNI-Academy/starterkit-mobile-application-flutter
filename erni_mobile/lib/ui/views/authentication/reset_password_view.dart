// coverage:ignore-file

import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/view_models/authentication/reset_password_view_model.dart';
import 'package:erni_mobile/ui/views/authentication/set_password_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_core/mvvm.dart';
import 'package:injectable/injectable.dart';

@Named(RouteNames.resetPassword)
@Injectable(as: Widget)
class ResetPasswordView extends StatelessWidget with ViewMixin<ResetPasswordViewModel> {
  ResetPasswordView() : super(key: const Key(RouteNames.resetPassword));

  @override
  Widget buildView(BuildContext context) {
    return SetPasswordView<ResetPasswordViewModel>(
      title: Il8n.of(context).changePasswordTitle,
      submitLabel: Il8n.of(context).changePasswordButtonLabel,
    );
  }
}
