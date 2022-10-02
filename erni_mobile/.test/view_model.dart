import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:reflectable/reflectable.dart';

import 'main.dart';

class Reflector extends Reflectable {
  const Reflector()
      : super(declarationsCapability, metadataCapability, invokingCapability);
}

const Reflector reflector = Reflector();

abstract class ViewModel extends ChangeNotifier {
  Future<void> onInitialize({Parameters? parameters}) async {}
}

const QueryParam idParam = QueryParam('id');

const QueryParam nameParam = QueryParam('name');

const QueryParam otherParam = QueryParam('other');

@reflector
class BViewModel extends ViewModel {
  @nameParam
  late final String? name;

  @idParam
  late final String? id;

  @otherParam
  late final BViewParam other;

  @override
  Future<void> onInitialize({Parameters? parameters}) async {
    log('Hello $name, your id is $id $other');
  }

  Future<void> goBack() async {
    NavigationService.pop('lorem');
  }
}

class BViewParam {}
