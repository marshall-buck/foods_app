import 'dart:async';
import 'dart:collection';
import 'dart:developer' as dev;

import 'package:foods_app/common/common.dart';
import 'package:foods_app/entities/entities.dart';

class SearchTermHistory {
  final StreamController<Queue<String?>> _streamController = StreamController<
      Queue<String?>>.broadcast(); // Use broadcast for multiple listeners

  Stream<Queue<String?>> get searchHistoryStream => _streamController.stream;

  final _history = Queue<String?>();
  static int maxHistory = MagicNumbers.defaultSearchHistory;

  void add(String term) {
    if (term.isNotEmpty) {
      _trimHistory();
      _history.addLast(term);
      _streamController.add(_history);
    }
  }

  void _trimHistory() {
    if (_history.length == maxHistory) {
      _history.removeFirst();
      _streamController.add(_history);
    }
  }

  void dispose() {
    _streamController.close();
  }
}

/// The source of truth showing the history of user interactions
/// throughout the app.
///
/// For example the history of recent foods clicked.
class AppHistoryState {
  static int maxHistory = MagicNumbers.defaultSearchHistory;

  // Will always insert most recent id as addLast.
  final _foodsHistory = Queue<Food?>();
  final _searchTermHistory = Queue<String?>();

  Food? get lastFood => _foodsHistory.last;
  String? get lastTerm => _searchTermHistory.last;

  Queue<String?> get searchTermHistory => _searchTermHistory;

  Queue<Food?> get foodsHistory => _foodsHistory;

  void addFoodToHistory(Food? food) {
    _trimHistory();
    if (food != null) {
      _foodsHistory.addLast(food);
    }
    dev.log(
      '${_foodsHistory.length}  ${_foodsHistory.last!.description}',
      name: ' AppHistoryState: addFoodToHistory Count',
    );
  }

  void addTermToHistory(String term) {
    if (term.isNotEmpty) {
      _trimHistory();
      _searchTermHistory.addLast(term);
    }

    dev.log('$_searchTermHistory', name: 'AppHistoryState: addTermToHistory');
  }

  /// Keeps the Queue a max length.
  void _trimHistory() {
    if (_foodsHistory.length == maxHistory) {
      _foodsHistory.removeFirst();
    }
    if (_searchTermHistory.length == maxHistory) {
      _searchTermHistory.removeFirst();
    }
  }

  void clearAll() {
    _searchTermHistory.clear();
    _foodsHistory.clear();
  }
}

// 2. Repository
// class MyRepository {
//   final StreamController<MyCustomObject> _objectController = StreamController<
//       MyCustomObject>.broadcast(); // Use broadcast for multiple listeners

//   Stream<MyCustomObject> get objectStream => _objectController.stream;

//   MyCustomObject _currentObject =
//       MyCustomObject(id: '', name: ''); // Initial value

//   void updateObject(MyCustomObject newObject) {
//     _currentObject = newObject; //Update the Current Object
//     _objectController.add(newObject); // Emit the new object on the stream
//   }

//   MyCustomObject getCurrentObject() {
//     return _currentObject;
//   }

//   void dispose() {
//     _objectController.close();
//   }
// }

// 3. BLoC
// class MyBloc extends Bloc<MyEvent, MyState> {
//   final MyRepository _repository;
//   StreamSubscription? _objectSubscription;

//   MyBloc({required MyRepository repository})
//       : _repository = repository,
//         super(MyInitialState()) {
//     on<UpdateMyObjectEvent>((event, emit) {
//       _repository.updateObject(event.newObject);
//     });

//     // Listen to the repository stream in the BLoC
//     _objectSubscription = _repository.objectStream.listen((newObject) {
//       emit(MyObjectUpdatedState(newObject));
//     });

//     //Initialize the state with the current object
//     emit(MyObjectUpdatedState(_repository.getCurrentObject()));
//   }

//   @override
//   Future<void> close() {
//     _objectSubscription?.cancel(); // Important: Cancel the subscription
//     return super.close();
//   }
// }

// 4. Events and States (Example)
// abstract class MyEvent {}

// class UpdateMyObjectEvent extends MyEvent {
//   final MyCustomObject newObject;
//   UpdateMyObjectEvent({required this.newObject});
// }

// abstract class MyState {}

// class MyInitialState extends MyState {}

// class MyObjectUpdatedState extends MyState {
//   final MyCustomObject updatedObject;
//   MyObjectUpdatedState(this.updatedObject);
// }

// Example Usage
// void main() {
//   final repository = MyRepository();
//   final bloc = MyBloc(repository: repository);

//   // Listen to the BLoC state changes in your UI
//   bloc.stream.listen((state) {
//     if (state is MyObjectUpdatedState) {
//       print("Object updated: ${state.updatedObject.name}");
//       // Update UI with state.updatedObject
//     }
//   });

//   // Trigger an update from the UI
//   bloc.add(UpdateMyObjectEvent(
//       newObject: MyCustomObject(id: '1', name: 'New Name')));
// }
