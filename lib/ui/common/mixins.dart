mixin PriceMixin {
  String trimDecimal(String data) {
    if (data.isEmpty) {
      return data;
    }
    final parts = data.split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];
    if (decimalPart.length <= 18) {
      return data;
    }

    return '$integerPart.${decimalPart.substring(0, 18)}';
  }
}
