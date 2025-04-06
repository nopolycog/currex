mixin PriceMixin {
  String trimDecimal(String data, {int maxLength = 18}) {
    if (data.isEmpty) {
      return data;
    }
    final parts = data.split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];
    if (decimalPart.length <= maxLength) {
      return data;
    }

    return '$integerPart.${decimalPart.substring(0, maxLength)}';
  }
}
