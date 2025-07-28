part of 'navigation_todo_cubit.dart';

class NavigationTodoCubitState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondBodyDisplayed;

  const NavigationTodoCubitState({
    this.selectedCollectionId,
    this.isSecondBodyDisplayed,
  });

  @override
  List<Object?> get props => [isSecondBodyDisplayed, selectedCollectionId];
}
