abstract class ConnectivityChecker {
  Future<void> initialize();

  bool isConnected();

  void dispose();
}
