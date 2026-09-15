# SGR Municipal

Mockup funcional de un sistema de gestión territorial para delegaciones municipales. Permite a un gestor territorial registrar actividades, dar seguimiento a compromisos colectivos, gestionar casos sociales con historial de gestiones, y realizar búsquedas avanzadas con reportabilidad.

## Vistas incluidas

- **Login** — inicio de sesión con validacion de entradas.
- **Mi panel** — resumen de metas del período e historial de actividades.
- **Agenda colectiva** — tubo de trabajo con filtros y seguimiento de compromisos.
- **Casos sociales** — historial secuencial de atenciones por usuario.
- **Búsqueda avanzada** — filtros, exportación y paginación de resultados.

## Tecnologías utilizadas

- **Backend:** Django 5.2.
- **Frontend:** HTML5, CSS3, JavaScript.
- **Librerías:** [SweetAlert2](https://sweetalert2.github.io/).
> Nota: este es un mockup funcional en el frontend. La lógica de guardado, autenticación y exportación todavía no está conectada a la base de datos — los datos que se ven son de ejemplo y viven en los archivos `.js` de cada vista.

## Cómo ejecutarlo

1. Clona o descarga el proyecto y entra a la carpeta raíz (donde está `manage.py`).

2. Crea y activa un entorno virtual:
- python -m venv entornito
- entornito\Scripts\activate      
- source entornito/bin/activate   


3. Instala las dependencias:

- pip install -r Requirements.txt


4. Aplica las migraciones (crea las tablas base de Django):

- python manage.py migrate


5. Levanta el servidor:

- python manage.py runserver


6. Abre el navegador en:

- http://127.0.0.1:8000/


## Estructura relevante

```
templates/
├── dashboard/
│   ├── dashboard.html
│   ├── agenda.html
│   ├── casos_sociales.html
│   └── busqueda.html
└── login/
    ├── login.html
    ├── forgot_password.html
    ├── forgot_password_sent.html
    └── reset_password.html
static/
├── css/
│   ├── styles.css      (dashboard, agenda, casos sociales, búsqueda)
│   └── login.css        (login y recuperación de contraseña)
└── js/
    ├── script.js         (dashboard)
    ├── agenda.js
    ├── casos-sociales.js
    ├── busqueda.js
    ├── login.js
    ├── forgot_password.js
    └── reset_password.js
