class DeepLinkEntity {
  const DeepLinkEntity(this.url, this.navigatableRoute);

  final Uri url;
  final String navigatableRoute;

  Map<String, String> get queries => url.queryParameters;

  bool get canNavigateToRoute => navigatableRoute.isNotEmpty;
}
