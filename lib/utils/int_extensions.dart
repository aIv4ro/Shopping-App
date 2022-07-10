extension IntExtensions on int {
  bool get isDigit {
    return this >= 0x30 && this <= 0x39;
  }

  bool get isLetter {
    return (this >= 0x41 && this <= 0x5A) ||
        (this >= 0x61 && this <= 0x7A);
  }

  bool get isLowerCase {
    return this >= 0x61 && this <= 0x7A;
  }

  bool get isUpperCase {
    return this >= 0x41 && this <= 0x5A;
  }
}

