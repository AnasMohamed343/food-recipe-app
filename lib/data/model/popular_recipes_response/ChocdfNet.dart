class ChocdfNet {
  ChocdfNet({
    this.label,
    this.quantity,
    this.unit,
  });

  ChocdfNet.fromJson(dynamic json) {
    label = json['label'];
    quantity = json['quantity'];
    unit = json['unit'];
  }
  String? label;
  double? quantity;
  String? unit;
  ChocdfNet copyWith({
    String? label,
    double? quantity,
    String? unit,
  }) =>
      ChocdfNet(
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

  // // In ChocdfNet class
  // factory ChocdfNet.fromChocdfNetModel(ChocdfNetModel? chocdfNetModel) {
  //   if (chocdfNetModel == null)
  //     throw ArgumentError('chocdfNetModel cannot be null');
  //   return ChocdfNet(
  //     label: chocdfNetModel.label,
  //     quantity: chocdfNetModel.quantity,
  //     unit: chocdfNetModel.unit,
  //   );
  // }
}
