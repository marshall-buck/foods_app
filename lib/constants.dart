// const usdaDBService = 'usdaDBService';
// const foodsDBService = 'foodsDBService';
// const externalDBService = 'externalDBService';

enum ServiceInstance {
  usdaDBService('usdaDBService'),
  foodsDBService('foodsDBService'),
  externalDBService('externalDBService');

  const ServiceInstance(String this.string);
  final String string;
}
