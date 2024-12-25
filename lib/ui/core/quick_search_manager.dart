import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter/widgets.dart';
import 'package:foods_app/common/common.dart';
import 'package:foods_app/data/services.dart';
import 'package:watch_it/watch_it.dart';

class QuickSearchManager extends ChangeNotifier {
  List<String> _quickSearchNames = [];

  List<String> get quickSearchNames => _quickSearchNames;

  Future<void> init() async {
    await getNames();
  }

  Future<void> getNames() async {
    try {
      // ignore: strict_raw_type
      final prefs = await di.getAsync<PreferencesService>(
        instanceName: LocatorInstanceNames.sharedPrefsService,
      );
      final quick = await prefs.getQuickSearchAmounts();
      final names = quick
          .map((id) {
            return NutrientDTO
                .originalNutrientTableEdit[int.parse(id)]!['name']!;
          })
          .toList()
          .reversed
          .toList();

      _quickSearchNames = names;
      notifyListeners();
    } catch (e) {
      dev.log(
        'error',
        time: DateTime.now(),
        name: 'QuickSearchManager.getNames()',
        error: e,
      );
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
    notifyListeners();
  }
}
