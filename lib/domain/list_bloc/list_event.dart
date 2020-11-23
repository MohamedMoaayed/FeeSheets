part of 'list_bloc.dart';

@immutable
abstract class ListEvent {}

class LoadRowsEvent extends ListEvent {}

class RowDeletedEvent extends ListEvent {}
