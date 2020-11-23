import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fee_sheets/infrastructure/googleSheetsApi.dart';
import 'package:meta/meta.dart';

part 'list_event.dart';
part 'list_state.dart';

class ListBloc extends Bloc<ListEvent, ListState> {
  ListBloc() : super(ListInitial());

  @override
  Stream<ListState> mapEventToState(
    ListEvent event,
  ) async* {
    try {
      if (event is LoadRowsEvent) {
        yield ListInitial();
        yield ListLoading();
        await fetchSheet();
        yield ListLoaded();
      }
      if (event is RowDeletedEvent) {
        yield ListLoading();
        await deleteRow();
        await fetchSheet();

        yield ListLoaded();
      }
    } catch (error) {
      yield ListError('Is the device online?');
      rethrow;
    }
  }
}
