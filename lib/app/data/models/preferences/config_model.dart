import '../../abstract/abstract_model.dart';

class Config implements AbstractModel<Config> {
  Config({
    required this.parametro,
    required this.valor,
    required this.fecha,
  });

  final String parametro;
  final String valor;
  final String fecha;

  @override
  Config copyWith({
    String? parametro,
    String? valor,
    String? fecha,
  }) =>
      Config(
        parametro: parametro ?? this.parametro,
        valor: valor ?? this.valor,
        fecha: fecha ?? this.fecha,
      );

  factory Config.fromJson(Map<String, dynamic> json) => Config(
        parametro: json["parametro"],
        valor: json["valor"],
        fecha: json["fecha"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "parametro": parametro,
        "valor": valor,
        "fecha": fecha,
      };
}
