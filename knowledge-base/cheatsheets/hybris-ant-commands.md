# Comandos Ant — SAP Commerce (Hybris)

| Comando | ¿Para qué sirve? |
|---------|------------------|
| `ant all` | Compila todas las extensiones sin limpiar los archivos compilados previamente. |
| `ant clean` | Elimina los archivos generados por la compilación (`classes`, `build`, etc.) sin recompilar. |
| `ant clean all` | Limpia los archivos compilados y recompila todas las extensiones. Es el comando más utilizado. |
| `ant build` | Compila el proyecto. En muchas configuraciones es similar a `ant all`. |
| `ant initialize` | Inicializa el sistema y recrea la base de datos. **Elimina todos los datos existentes.** |
| `ant updatesystem` | Actualiza el sistema aplicando cambios en extensiones, `items.xml` y configuración, manteniendo la base de datos. |
| `ant production` | Genera un build optimizado para un entorno de producción. |
| `ant customize` | Ejecuta las tareas de personalización definidas por el proyecto antes del build (si existen). |
| `ant unittests` | Ejecuta las pruebas unitarias. |
| `ant integrationtests` | Ejecuta las pruebas de integración. |
| `ant yunitinit` | Inicializa el entorno necesario para ejecutar pruebas. |
| `ant sonar` | Ejecuta el análisis de calidad de código con SonarQube (si está configurado). |
| `ant build -Dextname=<extension>` | Compila solo una extensión específica (ej. `ant build -Dextname=depraticore`). Mucho más rápido que `ant all` para cambios pequeños. |
