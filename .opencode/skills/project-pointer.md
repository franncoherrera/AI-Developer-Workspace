# Skill: Project Pointer (env var routing)

Usar cuando un proyecto es un **puntero** a código que vive en otra ubicación definida por variable de entorno.

## Detección

El proyecto tiene en su `AGENTS.md`: `**Esta carpeta es un PUNTERO**` o un campo `env_var` en `.opencode/settings.json`.

## Comportamiento

1. Leer la variable de entorno del proyecto (ej: `$DEPRATI_PROJECT_PATH`)
2. Si no existe → preguntar al usuario y sugerir que la defina
3. Si la carpeta no existe → error, avisar al usuario
4. **Todo el trabajo** (leer, escribir, tests, git) se hace desde la ruta de la variable
5. No modificar archivos dentro de `projects/<nombre>/` ni su base

## Validación

```powershell
$path = $env:<VAR_NAME>
if (-not $path) { throw "Falta la variable de entorno <VAR_NAME>" }
if (-not (Test-Path $path)) { throw "La carpeta $path no existe" }
```

## Consejo
Configurar el `workdir` del agente para que apunte automáticamente: en `.opencode/settings.json` del proyecto, agregar `"workdir": "${env:<VAR_NAME>}"`.
