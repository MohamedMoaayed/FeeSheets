part of 'list_bloc.dart';

@immutable
abstract class ListState {}

class ListInitial extends ListState {}

class ListLoading extends ListState {
  ListLoading();
}

class ListError extends ListState {
  final String message;
  ListError(this.message);
}
