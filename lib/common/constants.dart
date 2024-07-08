enum LocatorName {
  usdaDBService('usdaDBService'),
  foodsDBService('foodsDBService'),
  externalDBService('externalDBService');

  final String _name;

  const LocatorName(this._name);

  String get name => _name;
}
