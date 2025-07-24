import 'package:equatable/equatable.dart';

class EntryId extends Equatable {
  final String value;

  const EntryId(this.value);

  factory EntryId.fromUniqueString(String uniqueString) {
    return EntryId(uniqueString);
  }

  @override
  List<Object?> get props => [value];
}
