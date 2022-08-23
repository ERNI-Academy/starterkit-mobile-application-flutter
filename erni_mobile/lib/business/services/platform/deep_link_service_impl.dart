import 'package:erni_mobile/business/models/platform/deep_link_entity.dart';
import 'package:erni_mobile/common/utils/converters/deep_link_path_to_route_converter.dart';
import 'package:erni_mobile/domain/services/platform/deep_link_service.dart';
import 'package:erni_mobile_blueprint_core/utils.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: DeepLinkService)
class DeepLinkServiceImpl implements DeepLinkService {
  static const DeepLinkPathToRouteConverter _pathToRouteConverter = DeepLinkPathToRouteConverter();

  DeepLinkServiceImpl(this._appLinkService) {
    linkStream = _appLinkService.linkStream.map((url) => DeepLinkEntity(url, _pathToRouteConverter.convert(url.path)));
  }

  final AppLinkService _appLinkService;

  @override
  late final Stream<DeepLinkEntity> linkStream;

  @override
  Future<DeepLinkEntity?> getInitialLink() async {
    final url = await _appLinkService.getInitialLink();

    if (url == null) {
      return null;
    }

    return DeepLinkEntity(url, _pathToRouteConverter.convert(url.path));
  }

  @override
  Future<DeepLinkEntity?> getLatestLink() async {
    final url = await _appLinkService.getLatestLink();

    if (url == null) {
      return null;
    }

    return DeepLinkEntity(url, _pathToRouteConverter.convert(url.path));
  }
}
