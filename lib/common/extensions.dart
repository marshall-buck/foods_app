extension ConvertAmountToString on double {
  String convertAmountToString() {
    if (this == 0) return '0';
    if (this >= 50) {
      return toStringAsFixed(0);
    } else if (this >= 10) {
      return toStringAsFixed(1);
    } else if (this >= 1) {
      return toStringAsFixed(2);
    } else {
      return toStringAsFixed(3);
    }
  }
}
