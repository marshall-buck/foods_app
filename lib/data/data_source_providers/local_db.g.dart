// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_db.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$usdaDBHash() => r'd5fa7fab8b4607bacc195c9f98e2736bc49b850a';

/// See also [usdaDB].
@ProviderFor(usdaDB)
final usdaDBProvider = Provider<UsdaDB>.internal(
  usdaDB,
  name: r'usdaDBProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$usdaDBHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UsdaDBRef = ProviderRef<UsdaDB>;
String _$localDBHash() => r'a872a688a08066d20bed55a7db9bb87c4aada820';

/// See also [localDB].
@ProviderFor(localDB)
final localDBProvider = AutoDisposeProvider<FoodsDBInterface>.internal(
  localDB,
  name: r'localDBProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$localDBHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LocalDBRef = AutoDisposeProviderRef<FoodsDBInterface>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
