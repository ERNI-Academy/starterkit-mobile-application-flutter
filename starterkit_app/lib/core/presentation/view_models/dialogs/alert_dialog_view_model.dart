import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:starterkit_app/core/presentation/view_models/view_model.dart';
import 'package:starterkit_app/core/reflection.dart';

const QueryParam cancelTextParam = QueryParam('cancelText');

const QueryParam messageParam = QueryParam('message');

const QueryParam okTextParam = QueryParam('okText');

const QueryParam titleParam = QueryParam('title');

@injectable
@navigatable
class AlertDialogViewModel extends ViewModel {
  @titleParam
  String? title;

  @messageParam
  String? message;

  @okTextParam
  String? okText;

  @cancelTextParam
  String? cancelText;
}
