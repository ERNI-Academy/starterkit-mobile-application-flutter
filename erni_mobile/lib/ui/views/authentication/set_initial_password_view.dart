// coverage:ignore-file

import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/common/localization/localization.dart';
import 'package:erni_mobile/ui/view_models/authentication/set_initial_password_view_model.dart';
import 'package:erni_mobile/ui/views/authentication/set_password_view.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:erni_mobile_blueprint_core/mvvm.dart';
import 'package:injectable/injectable.dart';

@Named(RouteNames.setInitialPassword)
@Injectable(as: Widget)
class SetInitialPasswordView extends StatelessWidget with ViewMixin<SetInitialPasswordViewModel> {
  SetInitialPasswordView() : super(key: const Key(RouteNames.setInitialPassword));

  @override
  Widget buildView(BuildContext context) {
    return SetPasswordView<SetInitialPasswordViewModel>(
      title: Il8n.of(context).setInitialPasswordTitle,
      submitLabel: Il8n.of(context).setInitialPasswordButtonLabel,
    );
  }
}
