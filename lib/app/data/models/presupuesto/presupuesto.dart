import 'package:intl/intl.dart';

import '../../abstract/abstract_model.dart';

class Presupuesto implements AbstractModel<Presupuesto> {
  final int? id;
  final String descripcion;
  final double presupuesto;
  final DateTime fechaInsert;
  final DateTime? fechaUpdate;

  Presupuesto({
    this.id,
    required this.descripcion,
    required this.presupuesto,
    required this.fechaInsert,
    this.fechaUpdate,
  });

  @override
  Presupuesto copyWith({
    int? id,
    String? descripcion,
    double? presupuesto,
    DateTime? fechaInsert,
    DateTime? fechaUpdate,
  }) =>
      Presupuesto(
        id: id ?? this.id,
        descripcion: descripcion ?? this.descripcion,
        presupuesto: presupuesto ?? this.presupuesto,
        fechaInsert: fechaInsert ?? this.fechaInsert,
        fechaUpdate: fechaUpdate ?? this.fechaUpdate,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "presupuesto": presupuesto,
        "fecha_insert": DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaInsert),
        "fecha_update": fechaUpdate != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaUpdate!)
            : null,
      };

  factory Presupuesto.getDefault() => Presupuesto(
        descripcion: '',
        presupuesto: 0.0,
        fechaInsert: DateTime.now(),
      );

  factory Presupuesto.fromJson(Map<String, dynamic> json) => Presupuesto(
        id: json["id"],
        descripcion: json["descripcion"],
        presupuesto: json["presupuesto"],
        fechaInsert: DateTime.parse(json["fecha_insert"]),
        fechaUpdate: json["fecha_update"] != null
            ? DateTime.parse(json["fecha_update"])
            : null,
      );
}
