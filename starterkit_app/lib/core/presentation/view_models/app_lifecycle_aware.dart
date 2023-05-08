abstract class AppLifeCycleAware {
  Future<void> onAppPaused();

  Future<void> onAppResumed();

  Future<void> onAppInactive();

  Future<void> onAppDetached();
}
