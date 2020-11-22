part of 'form_bloc.dart';

@immutable
abstract class FormScreenState {}

class FormInitial extends FormScreenState {}

class FormLoading extends FormScreenState {
  FormLoading();
}

class FormError extends FormScreenState {
  final String message;
  FormError(this.message);
}
