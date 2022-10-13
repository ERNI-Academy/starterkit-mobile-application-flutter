// coverage:ignore-file

import 'package:erni_mobile/domain/services/ui/navigation/navigation_service.dart';
import 'package:erni_mobile/domain/ui/views/view_mixin.dart';
import 'package:erni_mobile/ui/resources/assets.gen.dart';
import 'package:erni_mobile/ui/view_models/main/splash_view_model.dart';
import 'package:erni_mobile/ui/widgets/widgets.dart';

class SplashView extends StatelessWidget with ViewMixin<SplashViewModel> {
  const SplashView() : super(key: const Key(SplashViewRoute.name));

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
  Widget buildView(BuildContext context, SplashViewModel viewModel) {
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
