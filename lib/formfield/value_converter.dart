/// Abstract class for Value converters to convert values from and to String values for the UI.
/// So in theory it is also possible to convert from a UI string to/from for example a string vor the database or an enum.
abstract class ValueConverter<T> {
  T? fromUiString(String? value);

  String? toUiString(T? value);
}
