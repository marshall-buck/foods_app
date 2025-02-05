// import 'package:flutter_test/flutter_test.dart';
// import 'package:foods_app/common/common.dart';
// import 'package:foods_app/domain/domain.dart';

// import 'package:watch_it/watch_it.dart';

// import '../setup/setup.dart';

// void main() {
//   startUpOnce();

//   setUp(() async {
//     await di.reset();

//     getPreferences();
//     registerDependencies();
//   });

//   group('FoodModel class Tests', () {
//     group('convertAmountToString()', () {
//       test('convertAmountToString for amounts >= 50', () {
//         expect(Food.convertAmountToString(50.123), '50');
//       });

//       test('convertAmountToString for amounts >= 10 and < 50', () {
//         expect(Food.convertAmountToString(15.456), '15.5');
//       });

//       test('convertAmountToString for amounts >= 1 and < 10', () {
//         expect(Food.convertAmountToString(2.345), '2.35');
//       });

//       test('convertAmountToString for amounts < 1', () {
//         expect(Food.convertAmountToString(0.1234), '0.123');
//       });
//     });
//   });
// }
