// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:erni_mobile_core/src/json/json_converter.dart' as _i7;
import 'package:erni_mobile_core/src/navigation/navigation_service.dart' as _i9;
import 'package:erni_mobile_core/src/navigation/route_generator.dart' as _i16;
import 'package:erni_mobile_core/src/navigation/view_locator.dart' as _i15;
import 'package:erni_mobile_core/src/utils/async/future_utils.dart' as _i6;
import 'package:erni_mobile_core/src/utils/messaging_center.dart' as _i8;
import 'package:erni_mobile_core/src/utils/platform/app_link_service.dart'
    as _i3;
import 'package:erni_mobile_core/src/utils/platform/configuration_checker.dart'
    as _i4;
import 'package:erni_mobile_core/src/utils/platform/connectivity_util.dart'
    as _i5;
import 'package:erni_mobile_core/src/utils/platform/platform_checker.dart'
    as _i10;
import 'package:erni_mobile_core/src/utils/platform/secure_storage_service.dart'
    as _i11;
import 'package:erni_mobile_core/src/utils/platform/shared_prefs_service.dart'
    as _i12;
import 'package:erni_mobile_core/src/utils/platform/url_launcher.dart' as _i14;
import 'package:erni_mobile_core/src/utils/ui_util.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _prod = 'prod';
const String _test = 'test';
const String _mobile = 'mobile';
const String _desktop = 'desktop';
const String _web = 'web';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.AppLinkService>(_i3.AppLinkServiceImpl.create(),
      registerFor: {_prod});
  gh.singleton<_i3.AppLinkService>(_i3.TestAppLinkServiceImpl(),
      registerFor: {_test});
  gh.lazySingleton<_i4.ConfigurationChecker>(
      () => _i4.ConfigurationCheckerImpl());
  await gh.singletonAsync<_i5.ConnectivityUtil>(
      () => _i5.ConnectivityUtilImpl.create(),
      registerFor: {_prod},
      preResolve: true,
      dispose: (i) => i.dispose());
  gh.singleton<_i5.ConnectivityUtil>(_i5.TestConnecivityUtilImpl(),
      registerFor: {_test}, dispose: (i) => i.dispose());
  gh.lazySingleton<_i6.FutureUtils>(() => _i6.FutureUtilsImpl());
  gh.lazySingleton<_i7.JsonConverter>(() => _i7.JsonConverterImpl());
  gh.lazySingleton<_i8.MessagingCenter>(() => _i8.MessagingCenterImpl());
  gh.lazySingleton<_i9.NavigationService>(() => _i9.NavigationServiceImpl());
  gh.lazySingleton<_i10.PlatformChecker>(() => _i10.IOPlatformCheckerImpl(),
      registerFor: {_mobile, _desktop});
  gh.lazySingleton<_i10.PlatformChecker>(() => _i10.WebPlatformCheckerImpl(),
      registerFor: {_web});
  gh.lazySingleton<_i11.SecureStorageService>(
      () => _i11.SecureStorageServiceImpl.create(),
      registerFor: {_prod});
  gh.singleton<_i11.SecureStorageService>(_i11.TestSecureStorageServiceImpl(),
      registerFor: {_test});
  await gh.singletonAsync<_i12.SharedPrefsService>(
      () => _i12.SharedPrefsServiceImpl.create(),
      registerFor: {_prod},
      preResolve: true);
  gh.lazySingleton<_i12.SharedPrefsService>(
      () => _i12.TestSharedPrefsServiceImpl(),
      registerFor: {_test});
  gh.lazySingleton<_i13.UiUtil>(() => _i13.UiUtilImpl());
  gh.lazySingleton<_i14.UrlLauncher>(() => _i14.UrlLauncherImpl());
  gh.lazySingleton<_i15.ViewLocator>(() => _i15.ViewLocatorImpl());
  gh.lazySingleton<_i16.RouteGenerator>(
      () => _i16.RouteGeneratorImpl(get<_i15.ViewLocator>()));
  return get;
}
