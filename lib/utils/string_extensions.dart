extension StringExtensions on String {
  String get capitalize {
    return length > 0
      ? replaceFirst(this[0], this[0].toUpperCase())
      : this;
  }
}

