import 'Hits.dart';

class RecipeResponse {
  RecipeResponse({
    this.q,
    this.from,
    this.to,
    this.more,
    this.count,
    this.hits,
    this.status,
    this.message,
  });

  RecipeResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    q = json['q'];
    from = json['from'];
    to = json['to'];
    more = json['more'];
    count = json['count'];
    if (json['hits'] != null) {
      hits = [];
      json['hits'].forEach((v) {
        hits?.add(Hits.fromJson(v));
      });
    }
  }
  String? status;
  String? message;
  String? q;
  int? from;
  int? to;
  bool? more;
  int? count;
  List<Hits>? hits;
  RecipeResponse copyWith({
    String? status,
    String? q,
    int? from,
    int? to,
    bool? more,
    int? count,
    List<Hits>? hits,
  }) =>
      RecipeResponse(
        status: status ?? this.status,
        q: q ?? this.q,
        from: from ?? this.from,
        to: to ?? this.to,
        more: more ?? this.more,
        count: count ?? this.count,
        hits: hits ?? this.hits,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['q'] = q;
    map['from'] = from;
    map['to'] = to;
    map['more'] = more;
    map['count'] = count;
    if (hits != null) {
      map['hits'] = hits?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
