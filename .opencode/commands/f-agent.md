---
description: Cambia el contexto al proyecto indicado. Resuelve la ruta real desde variables de entorno (uso: /f-agent <proyecto>)
---

# /f-agent

Cambiás el contexto de trabajo a un proyecto específico del workspace. El agente resuelve automáticamente la ruta real del proyecto.

## Uso

```
/f-agent <projectName>
```

## Qué hace

1. Busca el proyecto en `projects/<projectName>/AGENTS.md`
2. Si el proyecto tiene variables de entorno (`$<NAME>_PROJECT_PATH`, `$<NAME>_BASE_PROJECT_PATH`), las resuelve
3. Establece el directorio de trabajo en la ruta del código del proyecto (o pregunta al usuario si no está claro)
4. Carga las reglas del proyecto y la tecnología declarada

## MCPs por proyecto

Hay MCPs que solo se activan con el agente específico del proyecto.
Cuando cambies de contexto, **cambia también al agente correspondiente** en el selector de OpenCode.

| Proyecto | Agente | MCPs activos |
|----------|--------|-------------|
| deprati  | `deprati` | deprati-mcp, figma-mcp |

Los MCPs globales (`browser`, `filesystem`, `obsidian`) están siempre disponibles.

## Ejemplos

```
/f-agent deprati
/f-agent mi-nuevo-proyecto
```

## Proyectos disponibles

!`ls -1 projects/ 2>/dev/null | head -20`
