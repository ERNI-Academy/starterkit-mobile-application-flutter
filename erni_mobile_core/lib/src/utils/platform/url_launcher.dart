import 'package:injectable/injectable.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class UrlLauncher {
  Future<void> launch(
    Uri url, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  });

  Future<bool> canLaunch(Uri url);
}

@LazySingleton(as: UrlLauncher)
class UrlLauncherImpl implements UrlLauncher {
  @override
  Future<void> launch(
    Uri url, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) =>
      launchUrl(
        url,
        mode: mode,
        webViewConfiguration: webViewConfiguration,
        webOnlyWindowName: webOnlyWindowName,
      );

  @override
  Future<bool> canLaunch(Uri url) => canLaunchUrl(url);
}
