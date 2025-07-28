import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/1_domain/entities/collections_id.dart';

part 'navigation_todo_cubit_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoCubitState> {
  NavigationTodoCubit() : super(const NavigationTodoCubitState());

  void selectedTodoCollectionChanged(CollectionId collectionId){
    
    emit(NavigationTodoCubitState(selectedCollectionId: collectionId));

  }
  void secondBodyHasChanged({required bool isSecondBodyDisplayed}){
    emit(NavigationTodoCubitState(
        isSecondBodyDisplayed: isSecondBodyDisplayed,
        selectedCollectionId: state.selectedCollectionId,
    ));
  }
}
