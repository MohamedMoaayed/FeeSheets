import 'package:fee_sheets/infrastructure/savedValues.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.I;

void setupLocator() {
  locator.registerSingleton<SavedValues>(SavedValues());
}
