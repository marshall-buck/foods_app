import 'package:equatable/equatable.dart';

class AutocompleteItem extends Equatable {
  const AutocompleteItem({required this.description, required this.quickLook});
  final String description;
  final List<int> quickLook;

  @override
  List<Object?> get props => [description, quickLook];
  @override
  bool get stringify => true;
}
