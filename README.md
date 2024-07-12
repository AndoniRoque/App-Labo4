# Astronomy Picture of the Day (APOD)

APOD es una app que te permite consultar impactántes imágenes espaciales consumiendo una api de la NASA. Se puede ver la imagen del dia, seleccionar un dia en particular y se puede seleccionar dos fechas para traer la mejor imagen espacial de cada dia entre las fechas ingresadas.

## Final de Laboratorio de Computación IV 

La app fue desarrollada en Flutter y consta de las siguientes pantallas: 
- Pantalla de inicio - Trae por defecto la imagen del dia con una descripcion y su título.
- Pantalla de selección de un único dia - Permite al usuario ingresar una fecha y traer la imagen correspondiente a ese dia junto con su correspondiente titulo y descripción. 
- Pantalla de selección de múltiples dias - Permite al usuario ingresar dos fechas y se mostrará un listado de las mejores fotos de cada dia, cada tarjeta es clickeable para abrir...
- Pantalla de detalle - Se puede observar la foto seleccionada con más detalle y se puede leer la descripción de la foto.

### API

La app consume una API desarrollada en clase, hecha en Node.js, que actualmente esta hosteada en la plataforma [Render](https://render.com/). 

El código de la api se puede consultar en el siguiente [GitHub](https://github.com/AndoniRoque/node-js-heroku).

La dirección base de la api es https://node-js-heroku.onrender.com/api/v1/nasa y consta de los siguientes enpoints: 
- /pictures - trae las últimas 50 imagenes diarias.
- /picture/{YYYY-MM-DD} - trae la imagen del día ingresado en el formato Año-Mes-Día.
- /pictures_range?start_date={YYYY-MM-DD}&end_date={YYYY-MM-DD} - Trae una imagen por día entre las fechas ingresadas en el formato Año-Mes-Día.

No debería pedir más información pero por las dudas incluyo que se puede generar una API KEY en la dirección: https://api.nasa.gov/

### Información Adicional 

- Pixel 3A - API 35 (Emulador)
- Dart SDK version: 3.4.3

### Nota final

Es posible que al iniciarse la emulación del teléfono, éste se encuentre en una zona horaria "adelantada" a la nuestra y quiera consultar la foto del dia de mañana, asegurarse de que la fecha en el teléfono sea la de hoy. 
