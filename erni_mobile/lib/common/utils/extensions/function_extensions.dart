extension FunctionExtensions on Function {
  String get name {
    final fnName = '$this';
    final rgx = RegExp("'([^']*)'");
    var name = rgx.firstMatch(fnName)?.group(1) ?? '';

    if (name.contains('@')) {
      final ampersandIndex = name.indexOf('@');

      name = name.substring(0, ampersandIndex);
    }

    return name;
  }
}
