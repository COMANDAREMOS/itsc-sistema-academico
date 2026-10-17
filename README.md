# Sistema académico ITSC

Proyecto académico del Instituto Tecnológico Santa Cruz desarrollado con PHP, MariaDB y XAMPP. Los datos de personas y movimientos son ficticios.

**Estudiante:** Vicente Apaza Bautista  
**Docente:** Ing. Lozano Barro Jorge Robbert

## Archivos para la revisión

- [Proyecto completo con código fuente, base de datos, capturas y documentación](Proyecto_ITSC_para_GitHub.zip).
- [Práctico con carátula, capturas y diagrama de clases](Practico_ITSC.docx).
- [Base de datos MariaDB](Base_de_datos_ITSC.sql).
- [Diagrama de clases en imagen](Diagrama_de_Clases_ITSC.png).
- [Diagrama ampliable SVG](Diagrama_de_Clases_ITSC.svg).
- [Diagrama editable PlantUML](Diagrama_de_Clases_ITSC.puml).

## Instalación

1. Descargar y extraer `Proyecto_ITSC_para_GitHub.zip`.
2. Leer el `README.md` incluido en la carpeta extraída.
3. Iniciar Apache y MySQL en XAMPP.
4. Importar `database/Base_de_datos_ITSC.sql` en una instalación nueva, sin datos previos.
5. Copiar la carpeta `itsc` a `C:\xampp\htdocs\itsc`.
6. Ejecutar en PowerShell:

```powershell
& C:\xampp\php\php.exe C:\xampp\htdocs\itsc\setup.php
```

7. Guardar el acceso inicial que genera la consola y abrir http://localhost/itsc/.

La configuración y las contraseñas del equipo original no se publican. Cada instalación genera su propio acceso. La base contiene 37 tablas y 3 vistas. El diagrama muestra un modelo simplificado de 14 clases con operaciones propuestas de diseño.

## Funciones

Gestión de estudiantes, docentes, carreras, materias, matrículas, inscripciones, evaluaciones, asistencia, resultados, recuperaciones, cargos, pagos, documentos, trámites y pasantías. Incluye roles ADMIN, DOCENTE y CAJA, colores institucionales y modo oscuro.

Este es un proyecto de práctica y no un sistema oficial del instituto.
