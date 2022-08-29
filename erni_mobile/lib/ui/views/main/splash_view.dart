// coverage:ignore-file

import 'package:erni_mobile/common/constants/route_names.dart';
import 'package:erni_mobile/ui/resources/assets.gen.dart';
import 'package:erni_mobile/ui/view_models/main/splash_view_model.dart';
import 'package:erni_mobile/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';
import 'package:injectable/injectable.dart';

@Named(RouteNames.splash)
@Injectable(as: Widget)
class SplashView extends StatelessWidget with ViewMixin<SplashViewModel> {
  SplashView() : super(key: const Key(RouteNames.splash));

  @override
  SplashViewModel onCreateViewModel(BuildContext context) {
    // Optionally override this method to do other initialization on the view/view model
    return super.onCreateViewModel(context);
  }

  @override
  void onDisposeViewModel(BuildContext context, SplashViewModel viewModel) {
    // Optionally override this method for cleanup
    super.onDisposeViewModel(context, viewModel);
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: AdaptiveStatusBar(
        referenceColor: context.materialTheme.colorScheme.background,
        child: Center(
          child: Assets.graphics.icErniLogo.image(width: 128),
        ),
      ),
    );
  }
}
