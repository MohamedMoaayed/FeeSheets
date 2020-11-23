part of 'list_bloc.dart';

@immutable
abstract class ListState {}

class ListInitial extends ListState {}

class ListLoading extends ListState {
  ListLoading();
}

class ListLoaded extends ListState {
  ListLoaded();
}

class RowDeleted extends ListState {
  final int row;
  RowDeleted(this.row);
}

class ListError extends ListState {
  final String message;
  ListError(this.message);
}
