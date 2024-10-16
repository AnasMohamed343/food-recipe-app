class EnercKcal {
  EnercKcal({
    this.label,
    this.quantity,
    this.unit,
  });

  EnercKcal.fromJson(dynamic json) {
    label = json['label'];
    quantity = json['quantity'];
    unit = json['unit'];
  }
  String? label;
  double? quantity;
  String? unit;
  EnercKcal copyWith({
    String? label,
    double? quantity,
    String? unit,
  }) =>
      EnercKcal(
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

  // // In EnercKcal class
  // factory EnercKcal.fromEnercKcalModel(EnercKcalModel? enercKcalModel) {
  //   if (enercKcalModel == null)
  //     throw ArgumentError('enercKcalModel cannot be null');
  //   return EnercKcal(
  //     label: enercKcalModel.label,
  //     quantity: enercKcalModel.quantity,
  //     unit: enercKcalModel.unit,
  //   );
  // }
}
