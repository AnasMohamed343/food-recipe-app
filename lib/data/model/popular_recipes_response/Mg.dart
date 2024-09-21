class Mg {
  Mg({
    this.label,
    this.quantity,
    this.unit,
  });

  Mg.fromJson(dynamic json) {
    label = json['label'];
    quantity = json['quantity'];
    unit = json['unit'];
  }
  String? label;
  double? quantity;
  String? unit;
  Mg copyWith({
    String? label,
    double? quantity,
    String? unit,
  }) =>
      Mg(
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
