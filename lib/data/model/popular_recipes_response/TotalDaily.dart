import 'EnercKcal.dart';
import 'Fat.dart';
import 'Fasat.dart';
import 'Chocdf.dart';
import 'Fibtg.dart';
import 'Procnt.dart';
import 'Chole.dart';
import 'Na.dart';
import 'Ca.dart';
import 'Mg.dart';
import 'K.dart';
import 'Fe.dart';
import 'Zn.dart';
import 'P.dart';
import 'VitaRae.dart';
import 'Vitc.dart';
import 'Thia.dart';
import 'Ribf.dart';
import 'Nia.dart';
import 'Vitb6a.dart';
import 'Foldfe.dart';
import 'Vitb12.dart';
import 'Vitd.dart';
import 'Tocpha.dart';
import 'Vitk1.dart';

class TotalDaily {
  TotalDaily({
    this.enerckcal,
    this.fat,
    this.fasat,
    this.chocdf,
    this.fibtg,
    this.procnt,
    this.chole,
    this.na,
    this.ca,
    this.mg,
    this.k,
    this.fe,
    this.zn,
    this.p,
    this.vitarae,
    this.vitc,
    this.thia,
    this.ribf,
    this.nia,
    this.vitb6a,
    this.foldfe,
    this.vitb12,
    this.vitd,
    this.tocpha,
    this.vitk1,
  });

  TotalDaily.fromJson(dynamic json) {
    enerckcal = json['ENERC_KCAL'] != null
        ? EnercKcal.fromJson(json['ENERC_KCAL'])
        : null;
    fat = json['FAT'] != null ? Fat.fromJson(json['FAT']) : null;
    fasat = json['FASAT'] != null ? Fasat.fromJson(json['FASAT']) : null;
    chocdf = json['CHOCDF'] != null ? Chocdf.fromJson(json['CHOCDF']) : null;
    fibtg = json['FIBTG'] != null ? Fibtg.fromJson(json['FIBTG']) : null;
    procnt = json['PROCNT'] != null ? Procnt.fromJson(json['PROCNT']) : null;
    chole = json['CHOLE'] != null ? Chole.fromJson(json['CHOLE']) : null;
    na = json['NA'] != null ? Na.fromJson(json['NA']) : null;
    ca = json['CA'] != null ? Ca.fromJson(json['CA']) : null;
    mg = json['MG'] != null ? Mg.fromJson(json['MG']) : null;
    k = json['K'] != null ? K.fromJson(json['K']) : null;
    fe = json['FE'] != null ? Fe.fromJson(json['FE']) : null;
    zn = json['ZN'] != null ? Zn.fromJson(json['ZN']) : null;
    p = json['P'] != null ? P.fromJson(json['P']) : null;
    vitarae =
        json['VITA_RAE'] != null ? VitaRae.fromJson(json['VITA_RAE']) : null;
    vitc = json['VITC'] != null ? Vitc.fromJson(json['VITC']) : null;
    thia = json['THIA'] != null ? Thia.fromJson(json['THIA']) : null;
    ribf = json['RIBF'] != null ? Ribf.fromJson(json['RIBF']) : null;
    nia = json['NIA'] != null ? Nia.fromJson(json['NIA']) : null;
    vitb6a = json['VITB6A'] != null ? Vitb6a.fromJson(json['VITB6A']) : null;
    foldfe = json['FOLDFE'] != null ? Foldfe.fromJson(json['FOLDFE']) : null;
    vitb12 = json['VITB12'] != null ? Vitb12.fromJson(json['VITB12']) : null;
    vitd = json['VITD'] != null ? Vitd.fromJson(json['VITD']) : null;
    tocpha = json['TOCPHA'] != null ? Tocpha.fromJson(json['TOCPHA']) : null;
    vitk1 = json['VITK1'] != null ? Vitk1.fromJson(json['VITK1']) : null;
  }
  EnercKcal? enerckcal;
  Fat? fat;
  Fasat? fasat;
  Chocdf? chocdf;
  Fibtg? fibtg;
  Procnt? procnt;
  Chole? chole;
  Na? na;
  Ca? ca;
  Mg? mg;
  K? k;
  Fe? fe;
  Zn? zn;
  P? p;
  VitaRae? vitarae;
  Vitc? vitc;
  Thia? thia;
  Ribf? ribf;
  Nia? nia;
  Vitb6a? vitb6a;
  Foldfe? foldfe;
  Vitb12? vitb12;
  Vitd? vitd;
  Tocpha? tocpha;
  Vitk1? vitk1;
  TotalDaily copyWith({
    EnercKcal? enerckcal,
    Fat? fat,
    Fasat? fasat,
    Chocdf? chocdf,
    Fibtg? fibtg,
    Procnt? procnt,
    Chole? chole,
    Na? na,
    Ca? ca,
    Mg? mg,
    K? k,
    Fe? fe,
    Zn? zn,
    P? p,
    VitaRae? vitarae,
    Vitc? vitc,
    Thia? thia,
    Ribf? ribf,
    Nia? nia,
    Vitb6a? vitb6a,
    Foldfe? foldfe,
    Vitb12? vitb12,
    Vitd? vitd,
    Tocpha? tocpha,
    Vitk1? vitk1,
  }) =>
      TotalDaily(
        enerckcal: enerckcal ?? this.enerckcal,
        fat: fat ?? this.fat,
        fasat: fasat ?? this.fasat,
        chocdf: chocdf ?? this.chocdf,
        fibtg: fibtg ?? this.fibtg,
        procnt: procnt ?? this.procnt,
        chole: chole ?? this.chole,
        na: na ?? this.na,
        ca: ca ?? this.ca,
        mg: mg ?? this.mg,
        k: k ?? this.k,
        fe: fe ?? this.fe,
        zn: zn ?? this.zn,
        p: p ?? this.p,
        vitarae: vitarae ?? this.vitarae,
        vitc: vitc ?? this.vitc,
        thia: thia ?? this.thia,
        ribf: ribf ?? this.ribf,
        nia: nia ?? this.nia,
        vitb6a: vitb6a ?? this.vitb6a,
        foldfe: foldfe ?? this.foldfe,
        vitb12: vitb12 ?? this.vitb12,
        vitd: vitd ?? this.vitd,
        tocpha: tocpha ?? this.tocpha,
        vitk1: vitk1 ?? this.vitk1,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (enerckcal != null) {
      map['ENERC_KCAL'] = enerckcal?.toJson();
    }
    if (fat != null) {
      map['FAT'] = fat?.toJson();
    }
    if (fasat != null) {
      map['FASAT'] = fasat?.toJson();
    }
    if (chocdf != null) {
      map['CHOCDF'] = chocdf?.toJson();
    }
    if (fibtg != null) {
      map['FIBTG'] = fibtg?.toJson();
    }
    if (procnt != null) {
      map['PROCNT'] = procnt?.toJson();
    }
    if (chole != null) {
      map['CHOLE'] = chole?.toJson();
    }
    if (na != null) {
      map['NA'] = na?.toJson();
    }
    if (ca != null) {
      map['CA'] = ca?.toJson();
    }
    if (mg != null) {
      map['MG'] = mg?.toJson();
    }
    if (k != null) {
      map['K'] = k?.toJson();
    }
    if (fe != null) {
      map['FE'] = fe?.toJson();
    }
    if (zn != null) {
      map['ZN'] = zn?.toJson();
    }
    if (p != null) {
      map['P'] = p?.toJson();
    }
    if (vitarae != null) {
      map['VITA_RAE'] = vitarae?.toJson();
    }
    if (vitc != null) {
      map['VITC'] = vitc?.toJson();
    }
    if (thia != null) {
      map['THIA'] = thia?.toJson();
    }
    if (ribf != null) {
      map['RIBF'] = ribf?.toJson();
    }
    if (nia != null) {
      map['NIA'] = nia?.toJson();
    }
    if (vitb6a != null) {
      map['VITB6A'] = vitb6a?.toJson();
    }
    if (foldfe != null) {
      map['FOLDFE'] = foldfe?.toJson();
    }
    if (vitb12 != null) {
      map['VITB12'] = vitb12?.toJson();
    }
    if (vitd != null) {
      map['VITD'] = vitd?.toJson();
    }
    if (tocpha != null) {
      map['TOCPHA'] = tocpha?.toJson();
    }
    if (vitk1 != null) {
      map['VITK1'] = vitk1?.toJson();
    }
    return map;
  }
}
