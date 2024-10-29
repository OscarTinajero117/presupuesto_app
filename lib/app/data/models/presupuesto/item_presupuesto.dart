import 'package:intl/intl.dart';

import '../../abstract/abstract_model.dart';

class ItemPresupuesto implements AbstractModel<ItemPresupuesto> {
  final int id;
  final int idPresupuesto;
  final String descripcion;
  final double costo;
  final int cantidad;
  final DateTime fechaInsert;
  final DateTime? fechaUpdate;

  ItemPresupuesto({
    required this.id,
    required this.idPresupuesto,
    required this.descripcion,
    required this.costo,
    required this.cantidad,
    required this.fechaInsert,
    required this.fechaUpdate,
  });

  @override
  ItemPresupuesto copyWith({
    int? id,
    int? idPresupuesto,
    String? descripcion,
    double? costo,
    int? cantidad,
    DateTime? fechaInsert,
    DateTime? fechaUpdate,
  }) =>
      ItemPresupuesto(
        id: id ?? this.id,
        idPresupuesto: idPresupuesto ?? this.idPresupuesto,
        descripcion: descripcion ?? this.descripcion,
        costo: costo ?? this.costo,
        cantidad: cantidad ?? this.cantidad,
        fechaInsert: fechaInsert ?? this.fechaInsert,
        fechaUpdate: fechaUpdate ?? this.fechaUpdate,
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "id_presupuesto": idPresupuesto,
        "descripcion": descripcion,
        "costo": costo,
        "cantidad": cantidad,
        "fecha_insert": DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaInsert),
        "fecha_update": fechaUpdate != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(fechaUpdate!)
            : null,
      };

  factory ItemPresupuesto.fromJson(Map<String, dynamic> json) =>
      ItemPresupuesto(
        id: json["id"],
        idPresupuesto: json["id_presupuesto"],
        descripcion: json["descripcion"],
        costo: json["costo"],
        cantidad: json["cantidad"],
        fechaInsert: DateTime.parse(json["fecha_insert"]),
        fechaUpdate: json["fecha_update"] != null
            ? DateTime.parse(json["fecha_update"])
            : null,
      );
}
