extension StringExtension on String {
  /// Results this string with the first char uppercased
  ///
  /// january -> January
  String uppercaseFirst() {
    final first = substring(0, 1);
    return first.toUpperCase() + substring(1);
  }

  /// Results this string with the first char uppercased
  ///
  /// January -> january
  String lowercaseFirst() {
    final first = substring(0, 1);
    return first.toLowerCase() + substring(1);
  }
}
