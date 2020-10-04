class StringConversions {
  /// Need to call .toString() on enum value before passing as
  /// argument to this method
  static String enumValueAsString(String e) {
    return e?.split('.')?.last;
  }

  static String capitalize(String s) {
    String _updatedS;
    try {
      _updatedS = '${s[0].toUpperCase()}${s.substring(1)}';
    } catch (_) {
      _updatedS = s;
    }
    return _updatedS;
  }

  static String capitalizeEachWord(String s) {
    String _updatedS;
    try {
      _updatedS = s.split(' ').map((String str) => capitalize(str)).join(' ');
    } catch (_) {
      _updatedS = s;
    }
    return _updatedS;
  }
}
