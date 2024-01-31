# flutter_widgets_comarques

Flutter Widgets Comarques es una aplicación Flutter que proporciona información sobre comarcas de la Comunitat Valenciana. La aplicación está diseñada con varias pantallas para mostrar la información.

## Características

La aplicación consta de las siguientes pantallas:

1. **Pantalla de inicio**: Esta pantalla muestra el logotipo del instituto Álvaro Falomir, el título de la aplicación y dos campos de texto para que el usuario introduzca su nombre de usuario y contraseña.

2. **Pantalla de Provincias**: Esta pantalla muestra las tres provincias de la Comunitat Valenciana con su nombre y una imagen representativa.

3. **Pantalla de Comarcas**: Esta pantalla muestra una lista de comarcas para una provincia seleccionada. La información mostrada incluye el nombre de la comarca y una imagen representativa.

4. **Pantalla de Información de la Comarca**: Esta pantalla muestra información detallada sobre una comarca específica. La información incluye el nombre de la comarca, la capital, la población, la imagen representativa, la descripción y las coordenadas geográficas (latitud y longitud). 

5. **Pantalla de información meteorológica**: Esta pantalla muestra información sobre el tiempo actual de la comarca seleccionada. La información incluye una imagen del tiempo meteorológico actual, la temperatura actual y la dirección del viento.

## Requisitos del sistema

- SDK de Flutter: '>=3.2.3 <4.0.0'
- SDK de Dart: '>=2.12.0 <3.0.0'
- Android Studio, IntelliJ IDEA o VS Code con el plugin de Flutter
- Un dispositivo o emulador Android o iOS para las pruebas

## Instalación

1. Clona el repositorio en tu máquina local.
   ```
   git clone https://github.com/username/flutter_widgets_comarques.git
   ```
2. Navega al directorio del proyecto.
   ```
   cd flutter_widgets_comarques
   ```
3. Instala las dependencias.
   ```
   flutter pub get
   ```
4. Ejecuta la aplicación.
   ```
   flutter run
   ```

## Uso
Dado que la aplicación carece de navegabilidad, para poder ver las distintas pantallas hay que seguir el siguiente proceso:

1. Abre el repositorio con un IDE.

2. Localiza el archivo `main.dart` en la carpeta `lib` y ábrelo.

3. Modifica la línea 27 del archivo `main.dart`:

home: const Provincias(title: 'Les comarques de la comunitat'),

Cambia el nombre de la constante (Provincias) por el de la pantalla que quieras ver. 
Los nombres de las pantallas son:

· Comarcas
· HomePage
· InfoClima
· InfoComarca
· Provincias

Por ejemplo, si quieres ver la pantalla de inicio, cambia la línea 27 por:

home: const HomePage(title: 'Les comarques de la comunitat'),

4. Ejecuta la aplicación.

5. Para ver otra pantalla, repite los pasos 3 y 4.
