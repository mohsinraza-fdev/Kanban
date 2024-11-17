extension StringExtension on String {
  String toUpperFirst() {
    String firstLetter = substring(0, 1);
    return firstLetter.toUpperCase() + substring(1).toLowerCase();
  }

  String get initials {
    if (isEmpty) {
      return this;
    }
    List<String> initials = split(' ');
    initials.removeWhere((value) => value.isEmpty);
    initials = initials.map((e) => e.substring(0, 1).toUpperCase()).take(2).toList();
    return initials.join('');
  }
}
