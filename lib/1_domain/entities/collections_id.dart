import 'package:equatable/equatable.dart';

class CollectionId extends Equatable {
  final String value;

  const CollectionId(this.value);

  factory CollectionId.fromUniqueString(String uniqueString) {
    return CollectionId(uniqueString);
  }

  @override
  List<Object?> get props => [value];
}
