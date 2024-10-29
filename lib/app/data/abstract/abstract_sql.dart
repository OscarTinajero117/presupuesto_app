///AbstractSQL es una clase abstracta la cual es implementada
///en cada provider que realice consultas en la base de datos
///local.
///
///La estructura básica de cada Provider que consulte la BD es
///la siguiente:
///*Consultar un Item
///
///*Obtener la lista de Items
///
///*Decidir si guardar o insertar un Item
///
///*Guardar un Item
///
///*Actualizar un Item
///
///*Eliminar un Item
///
///*Eliminar todos los Items
///
abstract class AbstractSQL<T> {
  ///Obtiene el Item deseado de la tabla según los argumentos
  Future<T?> getItem({required List<Object> arguments});

  ///Obtiene todos los Items de la tabla indicada y los
  ///retorna en forma de lista
  Future<List<T>> getItems({required List<Object> arguments});

  ///Guarda o actualiza el Item, según sea el caso
  Future<T> saveItem({required T model});

  ///Inserta el Item a la base de datos en la tabla indicada
  Future<int> insertItem({required T model});

  ///Actualiza el Item en la base de datos en la tabla indicada
  Future<int> updateItem({required T model});

  ///Borra el Item en la base de datos en la tabla indicada
  Future<int> deleteItem({required T model});

  ///Borra todos los Items en la base de datos en la tabla indicada,
  ///se pueden añadir argumentos de ser necesaria la especificación
  Future<int> deleteAllItems({required List<Object> arguments});
}
