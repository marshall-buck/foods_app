import 'dart:async';
import 'dart:collection';

import 'package:flutter_test/flutter_test.dart';
import 'package:foods_app/shared_repo/app_history_state.dart';
import 'package:mocktail/mocktail.dart';

class MockStreamController extends Mock
    implements StreamController<Queue<String?>> {}

void main() {
  group('SearchTermHistory', () {
    late SearchTermHistory searchTermHistory;
    late MockStreamController mockStreamController;

    setUp(() {
      mockStreamController = MockStreamController();
      searchTermHistory = SearchTermHistory();
    });

    group('add', () {
      test('should add a term to the history and notify listeners', () {
        const term = 'apple';
        searchTermHistory.add(term);

        expect(
          searchTermHistory.searchHistoryStream,
          emits(isA<Queue<String?>>()),
        );
        expect(searchTermHistory.searchHistoryStream, emits(contains(term)));
      });

      test('should not add an empty term to the history', () {
        searchTermHistory.add('');

        expect(
          searchTermHistory.searchHistoryStream,
          emits(isA<Queue<String?>>()),
        );
        expect(searchTermHistory.searchHistoryStream, emits(isEmpty));
      });
    });

    group('_trimHistory', () {
      test('should remove the oldest term when history exceeds max length', () {
        SearchTermHistory.maxHistory = 2;
        searchTermHistory
          ..add('apple')
          ..add('banana')
          ..add('cherry');

        expect(
          searchTermHistory.searchHistoryStream,
          emits(isA<Queue<String?>>()),
        );
        expect(
          searchTermHistory.searchHistoryStream,
          emits(contains('banana')),
        );
        expect(
          searchTermHistory.searchHistoryStream,
          emits(contains('cherry')),
        );
        expect(
          searchTermHistory.searchHistoryStream,
          emits(isNot(contains('apple'))),
        );
      });
    });

    group('dispose', () {
      test('should close the stream controller', () {
        searchTermHistory.dispose();

        verify(() => mockStreamController.close()).called(1);
      });
    });
  });
}
