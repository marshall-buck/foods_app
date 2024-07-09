import 'package:equatable/equatable.dart';

class SearchResultItem extends Equatable {
  final String description;
  final List<int> amounts;

  const SearchResultItem({required this.description, required this.amounts});

  @override
  bool? get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => [description, amounts];
}
