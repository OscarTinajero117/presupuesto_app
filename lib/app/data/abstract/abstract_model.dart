///AbstractModel es una clase abstracta la cual es implementada
///por cada modelo del sistema, estos métodos serán necesarios
///cada uno de dichos modelos
///
///La estructura de cada Modelo es la siguiente:
///
///*Atributos y Constructor
///
///*Un factory.fromJson que es del tipo de dato de la clase
///
///*Un método toJson
///
///
///*Un método copyWith
abstract class AbstractModel<T> {
  ///Retorna un json con los respectivos valores de las clases.
  ///(Hace la conversión de Modelo a JSON)
  Map<String, dynamic> toJson();

  ///Copia en la cuál se reemplazan los elementos deseados
  T copyWith();
}
