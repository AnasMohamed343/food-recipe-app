class Fat {
  Fat({
    this.label,
    this.quantity,
    this.unit,
  });

  Fat.fromJson(dynamic json) {
    label = json['label'];
    quantity = json['quantity'];
    unit = json['unit'];
  }
  String? label;
  double? quantity;
  String? unit;
  Fat copyWith({
    String? label,
    double? quantity,
    String? unit,
  }) =>
      Fat(
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
  //
  // // In Fat class
  // factory Fat.fromFatModel(FatModel? fatModel) {
  //   if (fatModel == null) throw ArgumentError('fatModel cannot be null');
  //   return Fat(
  //     label: fatModel.label,
  //     quantity: fatModel.quantity,
  //     unit: fatModel.unit,
  //   );
  // }
}
