# Pokémon Viewer App

Esta aplicación de SwiftUI permite buscar información sobre Pokémon utilizando la [PokeAPI](https://pokeapi.co/). 
Los usuarios pueden introducir el nombre de un Pokémon y visualizar detalles como su nombre, número de Pokédex, peso, tipo, movimientos y estadísticas básicas.

## Ejemplo visual

El diseño incluye un fondo con desenfoque, un campo de búsqueda estilizado y una tarjeta donde se presentan los resultados. 
Las estadísticas se muestran con gráficos de barras coloridos para facilitar la comprensión.

![Captura de pantalla](./Resources/Screenshot.jpg)

## Características principales

- **Búsqueda de Pokémon**: Introduce el nombre del Pokémon en un campo de texto para obtener información relevante.
- **Visualización de estadísticas**: Muestra estadísticas como salud, ataque, defensa y más, mediante gráficos de barras (Gauges) personalizables.
- **Información adicional**: Incluye el nombre, peso, número de Pokédex y una imagen del Pokémon, además de una lista de sus movimientos.
- **Interfaz amigable**: Una interfaz diseñada con SwiftUI que incluye un fondo desenfocado y componentes estilizados.

## Arquitectura

El código utiliza las siguientes entidades principales:

1. **`ContentView`**:
   - Es la vista principal que contiene el campo de búsqueda y muestra los resultados.
   - Utiliza el método `onSubmit` para realizar una llamada asíncrona a la API al introducir un nombre.
   - Carga y presenta los datos del Pokémon, o utiliza datos predeterminados si no se encuentra ninguno.

2. **`CreateResultView`**:
   - Es una subvista que muestra los detalles del Pokémon obtenido de la API.
   - Presenta información en forma de texto, imágenes y gráficos de progreso para estadísticas.

3. **Funciones auxiliares**:
   - `mapToRange`: Escala valores de estadísticas a un rango visual para los gráficos.
   - `typeTranslator`: Traduce los tipos de Pokémon del inglés al español.

## Dependencias

- **SwiftUI**: Para el diseño de la interfaz.
- **AsyncImage**: Para cargar imágenes de forma asíncrona.
- **PokeAPI**: Para obtener datos de los Pokémon.

## Cómo usar

1. Introduce el nombre del Pokémon en el campo de texto.
2. Pulsa la tecla de entrada para buscar.
3. Visualiza la información detallada del Pokémon en la pantalla principal.