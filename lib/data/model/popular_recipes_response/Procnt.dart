class Procnt {
  Procnt({
    this.label,
    this.quantity,
    this.unit,
  });

  Procnt.fromJson(dynamic json) {
    label = json['label'];
    quantity = json['quantity'];
    unit = json['unit'];
  }
  String? label;
  double? quantity;
  String? unit;
  Procnt copyWith({
    String? label,
    double? quantity,
    String? unit,
  }) =>
      Procnt(
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
  // // In Procnt class
  // factory Procnt.fromProcntModel(ProcntModel? procntModel) {
  //   if (procntModel == null) throw ArgumentError('procntModel cannot be null');
  //   return Procnt(
  //     label: procntModel.label,
  //     quantity: procntModel.quantity,
  //     unit: procntModel.unit,
  //   );
  // }
}
