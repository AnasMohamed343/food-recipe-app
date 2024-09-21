class Chocdf {
  Chocdf({
    this.label,
    this.quantity,
    this.unit,
  });

  Chocdf.fromJson(dynamic json) {
    label = json['label'];
    quantity = json['quantity'];
    unit = json['unit'];
  }
  String? label;
  double? quantity;
  String? unit;
  Chocdf copyWith({
    String? label,
    double? quantity,
    String? unit,
  }) =>
      Chocdf(
        label: label ?? this.label,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['quantity'] = quantity;
    map['unit'] = unit;
    return map;
  }
}
