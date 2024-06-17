/// Interface for for a foods database.

abstract interface class FoodsDBInterface<T> {
  Future<T> queryFood<U>({required U id});
  Future<List<T>> queryFoods({required String searchTerm});
}
