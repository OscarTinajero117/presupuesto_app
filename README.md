# PresupuestoApp

Una aplicación simple y útil para gestionar el presupuesto personal, ayudando a los usuarios a registrar sus compras y calcular en tiempo real cuánto les queda para gastar. La app elimina la necesidad de llevar una libreta para las cuentas, facilitando el control de los gastos de forma rápida y efectiva.

## Características

- **Registro de presupuestos**: Permite crear, editar y eliminar presupuestos para diferentes categorías.
- **Control de gastos**: Agrega y elimina ítems dentro de cada presupuesto, restando automáticamente su costo del total.
- **Visualización de saldo**: Muestra el total restante y cambia de color dependiendo del porcentaje del presupuesto que quede disponible.
- **Interfaz intuitiva**: Diseño limpio y sencillo, facilitando la navegación y el uso.

## Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/tu-usuario/presupuesto_app.git
   ```

2. Navega al directorio del proyecto:

   ```bash
   cd presupuesto_app
   ```

3. Instala las dependencias:

   ```bash
   flutter pub get
   ```

4. Ejecuta la aplicación:

   ```bash
   flutter run
   ```

## Estructura del Proyecto

- **HomePage**: Vista principal donde se listan todos los presupuestos creados y se permite agregar o eliminar presupuestos.
- **PresupuestoPage**: Detalle de cada presupuesto. Permite registrar los ítems, incluyendo el nombre, costo y cantidad, y calcula el total restante automáticamente.

## Tecnologías y Paquetes

- **Flutter**
- **GetX**: Para la gestión de estado y navegación.
- **Material UI**: Para una interfaz limpia y fácil de usar.
- **SQFLite**: Base de datos SQLite para flutter.
- **Flex Color Scheme**: Temas para la aplicación.
- **Path**: Para el manejo de los directorios.
- **Intl & Flutter Localizations**: Para el formateo del tiempo.

## Uso

1. Desde la pantalla principal, agrega un presupuesto con el nombre y el monto total asignado.
2. Dentro del presupuesto, registra los ítems con su costo y cantidad.
3. Observa en tiempo real cuánto queda del presupuesto disponible.
4. Edita o elimina ítems o presupuestos según tus necesidades.

## Contribuciones

Las contribuciones son bienvenidas. Si deseas agregar nuevas funcionalidades o mejorar la app, abre un PR o crea un issue para discutirlo.

## Licencia

MIT
