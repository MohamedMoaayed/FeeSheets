part of 'list_bloc.dart';

@immutable
abstract class ListEvent {}

class RowDeletedEvent extends ListEvent {}
