class CapitalizeFirstLetter {
  String capitalizeFirstLetter(String string) {
    if (string.isEmpty) {
      return string;
    }
    return string.substring(0, 1).toUpperCase() +
        string.substring(1).toLowerCase();
  }
}
