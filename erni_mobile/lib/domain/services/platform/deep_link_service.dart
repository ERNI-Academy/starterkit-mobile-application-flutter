import 'package:erni_mobile/business/models/platform/deep_link_entity.dart';

abstract class DeepLinkService {
  Stream<DeepLinkEntity> get linkStream;

  Future<DeepLinkEntity?> getInitialLink();

  Future<DeepLinkEntity?> getLatestLink();
}
