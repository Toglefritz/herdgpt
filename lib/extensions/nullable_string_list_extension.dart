/// Extension on `List<String?>` to provide utility methods for working with nullable string lists.
extension NullableStringListExtension on List<String?> {
  /// Checks if all elements in the list are null.
  ///
  /// Returns `true` if all values in the list are null, otherwise `false`.
  bool get areAllElementsNull {
    for (String? element in this) {
      if (element != null) {
        return false;
      }
    }
    return true;
  }

  /// Sets all values of the list to null.
  ///
  /// This method iterates through the list and sets each element to null.
  void setAllElementsToNull() {
    for (int i = 0; i < length; i++) {
      this[i] = null;
    }
  }
}