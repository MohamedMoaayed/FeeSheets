import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fee_sheets/infrastructure/googleSheetsApi.dart';
import 'package:meta/meta.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormScreenState> {
  FormBloc() : super(FormInitial());

  @override
  Stream<FormScreenState> mapEventToState(
    FormEvent event,
  ) async* {
    try {
      if (event is SubmitEvent) {
        yield FormLoading();

        await insertIntoSheet();
      }
    } catch (error) {
      yield FormError('Is the device online?');
      rethrow;
    }
  }
}
