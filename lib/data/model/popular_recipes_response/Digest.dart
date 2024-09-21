import 'Sub.dart';

class Digest {
  Digest({
    this.label,
    this.tag,
    this.schemaOrgTag,
    this.total,
    this.hasRDI,
    this.daily,
    this.unit,
    this.sub,
  });

  Digest.fromJson(dynamic json) {
    label = json['label'];
    tag = json['tag'];
    schemaOrgTag = json['schemaOrgTag'];
    total = json['total'];
    hasRDI = json['hasRDI'];
    daily = json['daily'];
    unit = json['unit'];
    if (json['sub'] != null) {
      sub = [];
      json['sub'].forEach((v) {
        sub?.add(Sub.fromJson(v));
      });
    }
  }
  String? label;
  String? tag;
  String? schemaOrgTag;
  double? total;
  bool? hasRDI;
  double? daily;
  String? unit;
  List<Sub>? sub;
  Digest copyWith({
    String? label,
    String? tag,
    String? schemaOrgTag,
    double? total,
    bool? hasRDI,
    double? daily,
    String? unit,
    List<Sub>? sub,
  }) =>
      Digest(
        label: label ?? this.label,
        tag: tag ?? this.tag,
        schemaOrgTag: schemaOrgTag ?? this.schemaOrgTag,
        total: total ?? this.total,
        hasRDI: hasRDI ?? this.hasRDI,
        daily: daily ?? this.daily,
        unit: unit ?? this.unit,
        sub: sub ?? this.sub,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['tag'] = tag;
    map['schemaOrgTag'] = schemaOrgTag;
    map['total'] = total;
    map['hasRDI'] = hasRDI;
    map['daily'] = daily;
    map['unit'] = unit;
    if (sub != null) {
      map['sub'] = sub?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
