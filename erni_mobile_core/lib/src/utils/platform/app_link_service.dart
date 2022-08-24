import 'package:app_links/app_links.dart';
import 'package:injectable/injectable.dart';

abstract class AppLinkService {
  Stream<Uri> get linkStream;

  Future<Uri?> getInitialLink();

  Future<Uri?> getLatestLink();
}

@Singleton(as: AppLinkService)
@prod
class AppLinkServiceImpl implements AppLinkService {
  AppLinkServiceImpl(this._appLinks);

  final AppLinks _appLinks;

  @override
  Stream<Uri> get linkStream => _appLinks.uriLinkStream;

  @factoryMethod
  static AppLinkService create() => AppLinkServiceImpl(AppLinks());

  @override
  Future<Uri?> getInitialLink() => _appLinks.getInitialAppLink();

  @override
  Future<Uri?> getLatestLink() => _appLinks.getLatestAppLink();
}

@Singleton(as: AppLinkService)
@test
class TestAppLinkServiceImpl implements AppLinkService {
  @override
  Stream<Uri> get linkStream => const Stream.empty();

  @override
  Future<Uri?> getInitialLink() => Future.value();

  @override
  Future<Uri?> getLatestLink() => Future.value();
}
