---
name: respawn-init
description: >
    Inicializa o actualiza un proyecto Respawn: copia las skills de la casa a
    .claude/skills/ del proyecto, crea el esqueleto de .ai/ y el CLAUDE.md, y
    anota la versión de la casa. Usar solo ante un pedido explícito del
    usuario: /respawn-init, "inicializá este proyecto como Respawn", "arrancá
    un proyecto Respawn en esta carpeta", "convertí este repositorio en
    proyecto Respawn", "actualizá las skills de Respawn de este proyecto",
    "traé la última versión de la casa". No usar por iniciativa propia ni en
    un repositorio que el usuario no pidió inicializar. No usar para relevar
    al cliente ni definir el paquete (es de respawn-kickoff), para registrar
    decisiones, deuda o estado (es de respawn-proyecto) ni para crear el
    código del sitio o del sistema (es de respawn-web y respawn-sistemas).
---

# Respawn Init — inicializar y actualizar un proyecto

## Contenido

0. Convenciones
1. Qué hace el script
2. Antes de correr
3. Correr el script
4. Después de inicializar
5. Actualizar un proyecto
6. Instalar la casa en una máquina
7. Antipatrones
8. Referencias

---

## 0. Convenciones

Esta es la única skill de la casa instalada globalmente: el agente la ve en
cualquier repositorio `*(Ver ADR-008)*`. Por eso se activa solo a pedido.

- **Todo lo mecánico lo hace el script** `scripts/init.sh`. El agente no copia
  skills ni crea el esqueleto a mano.
- **Una sola corrida para los dos casos:** el script inicializa un proyecto
  nuevo y actualiza uno ya inicializado.
- **La copia de las skills es de solo lectura** en el proyecto
  `*(Ver ADR-001)*`.
- **Sin commit:** el agente no hace commit ni sube los cambios sin pedido del
  usuario.
- **Ante una carpeta que no encaja en la tabla de casos:** preguntar al
  usuario antes de correr.

---

## 1. Qué hace el script

| Paso                 | Qué hace                                                                                         | Qué nunca hace                                  |
| -------------------- | ------------------------------------------------------------------------------------------------ | ----------------------------------------------- |
| Skills               | Copia cada skill de la casa a `.claude/skills/` y reemplaza la copia anterior                    | Tocar una skill que no es de la casa            |
| Skills retiradas     | Quita de `.claude/skills/` las carpetas con `respawn` en el nombre que ya no existen en la casa  | Copiar `respawn-init` ni las carpetas `evals/`  |
| Esqueleto de `.ai/`  | Crea `brief.md`, `decisiones.md`, `estado.md`, `entrega.md` y `adrs/ADR-P-001-stack.md`          | Pisar un archivo que ya existe                  |
| `CLAUDE.md` nuevo    | Lo crea desde la plantilla, con el nombre de la carpeta y la versión                             | —                                               |
| `CLAUDE.md` Respawn  | Actualiza solo la línea de la versión                                                            | Cambiar el resto del archivo                    |
| `CLAUDE.md` ajeno    | Avisa con `ATENCION` y lo deja como está                                                         | Pisarlo o agregarle texto                       |

La versión sale del primer número de `CHANGELOG.md` de la casa
`*(Ver ADR-007)*`. Las plantillas son de
[respawn-proyecto](../respawn-proyecto/SKILL.md).

---

## 2. Antes de correr

Mirar la carpeta y decidir con esta tabla:

| Situación de la carpeta                                           | Qué hacer                                                                      |
| ----------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| Vacía o recién creada                                             | Correr                                                                         |
| `CLAUDE.md` que abre con `# Proyecto Respawn`                     | Es una actualización: seguir el flujo de actualizar                            |
| Proyecto con código y sin `CLAUDE.md`                             | Confirmar con el usuario que es un proyecto Respawn y correr                   |
| Proyecto con un `CLAUDE.md` propio                                | Avisar que el script no lo va a tocar y correr                                 |
| Proyecto con skills propias en `.ai/skills/` o `.claude/skills/`  | Preguntar antes de correr: sus reglas pueden chocar con las de la casa         |
| No es un repositorio de git                                       | Avisar que la copia y el `.ai/` se versionan y preguntar si se inicializa git  |
| Es el repositorio de la casa                                      | No correr                                                                      |

---

## 3. Correr el script

1. **Anunciar** en una línea la carpeta del proyecto y el comando.
2. **Correr** con bash, desde la carpeta de esta skill:
   `bash scripts/init.sh "{carpeta del proyecto}"`.
3. **Leer la salida completa**: cada línea dice qué copió, creó, actualizó o
   dejó como estaba.
4. **Informar** al usuario el resultado y la versión de la casa.

- En Windows el script corre con Git Bash.
- Si el script termina con `ERROR`, informar el mensaje y no reintentar con
  otra carpeta sin consultar.

---

## 4. Después de inicializar

| La salida dice                                   | Qué hacer                                                                                    |
| ------------------------------------------------ | -------------------------------------------------------------------------------------------- |
| `creado CLAUDE.md`                               | Nada más: el resto del archivo lo completa `respawn-kickoff`                                 |
| `ATENCION CLAUDE.md existe y no es…`             | Proponer al usuario la integración de la plantilla y aplicarla con su aprobación             |
| `existe` en archivos de `.ai/`                   | Dejarlos: son la memoria del proyecto                                                        |

**Integrar un `CLAUDE.md` propio:**

1. Leer el `CLAUDE.md` del proyecto y la plantilla de `respawn-proyecto`.
2. Proponer el resultado: el título `# Proyecto Respawn · {nombre}`, la línea
   de versión y las secciones de skills y de memoria, conservando todo el
   contenido que ya tenía.
3. Aplicar el cambio recién con la aprobación del usuario.

**Proyecto que ya guarda su brief o sus decisiones en otra carpeta:** no
duplicar. Declarar esas rutas en la tabla de memoria del `CLAUDE.md` y, con
la aprobación del usuario, borrar los archivos de `.ai/` que el script creó y
quedaron sin uso.

**Siguiente paso:** proponer el relevamiento con
[respawn-kickoff](../respawn-kickoff/SKILL.md). En un proyecto que ya tiene
trabajo hecho, proponer completar el brief y el registro de decisiones con lo
que existe.

---

## 5. Actualizar un proyecto

1. **Leer** la versión anotada en el `CLAUDE.md` del proyecto.
2. **Correr** el script como en una inicialización.
3. **Leer** en el `CHANGELOG.md` de la casa las entradas entre la versión
   anterior y la nueva. La ruta de la casa figura en la primera línea de la
   salida.
4. **Informar** al usuario qué reglas cambiaron y cuáles pueden dejar al
   proyecto fuera de norma.
5. **Proponer** una auditoría con
   [review-respawn](../review-respawn/SKILL.md) si hubo un cambio de versión
   mayor.

- La actualización no toca `.ai/`: los desvíos que aparezcan con las reglas
  nuevas se registran como deuda con
  [respawn-proyecto](../respawn-proyecto/SKILL.md).
- Si la copia del proyecto tenía ediciones locales, se pierden. Antes de
  correr, revisar `git status` y avisar al usuario si hay cambios sin commit
  en `.claude/skills/`.

---

## 6. Instalar la casa en una máquina

Se hace una vez por máquina, desde la raíz del repositorio `respawn-skills`:

| Sistema | Comando                 | Enlace que crea        |
| ------- | ----------------------- | ---------------------- |
| Windows | `.\install.ps1`         | Junction, sin permisos de administrador |
| Linux   | `bash install.sh`       | Enlace simbólico       |

El instalador hace dos cosas `*(Ver ADR-007)*`:

- Enlaza `respawn-init` en la carpeta global de skills.
- Enlaza `skills/` como `.claude/skills` dentro de la casa, para que sus
  skills estén activas al trabajar en ella.

- Si en el destino hay una carpeta real, el instalador se detiene sin
  tocarla.
- Mover el repositorio de la casa rompe los enlaces: hay que correr el
  instalador de nuevo.
- Después de instalar, reiniciar Claude Code.

---

## 7. Antipatrones

| Antipatrón                                                          | Resolución                                                              |
| ------------------------------------------------------------------- | ----------------------------------------------------------------------- |
| Inicializar un repositorio porque «parece» de Respawn               | Esperar el pedido explícito del usuario                                 |
| Copiar las skills a mano, con el explorador o con comandos sueltos  | Correr el script: es el que anota la versión                            |
| Pisar o reescribir un `CLAUDE.md` que ya existía                    | Proponer la integración y esperar la aprobación                         |
| Editar una skill en `.claude/skills/` del proyecto                  | Cambiarla en la casa y actualizar el proyecto                           |
| Instalar todas las skills de la casa en la carpeta global           | Global va solo `respawn-init`; el resto llega con la copia              |
| Actualizar y no leer el registro de cambios                         | Leer las entradas entre versiones e informar qué reglas cambiaron       |
| Crear a mano los archivos de `.ai/` con otro formato                | Usar las plantillas de `respawn-proyecto` que copia el script           |
| Hacer commit de la inicialización sin que lo pidan                  | Informar lo creado y dejar el commit al usuario                         |

---

## 8. Referencias

| Archivo                                                      | Contenido                                                            |
| ------------------------------------------------------------ | -------------------------------------------------------------------- |
| [scripts/init.sh](scripts/init.sh)                           | Script de inicialización y actualización de un proyecto              |
| [evals/activacion.json](evals/activacion.json)               | Consultas de activación de esta skill                                |
| [../respawn-proyecto/SKILL.md](../respawn-proyecto/SKILL.md) | Formato de la capa proyecto y plantillas que copia el script         |
| [../respawn-kickoff/SKILL.md](../respawn-kickoff/SKILL.md)   | Relevamiento del cliente, paquete y alcance                          |
| [../review-respawn/SKILL.md](../review-respawn/SKILL.md)     | Auditoría de entrega                                                 |
| `install.ps1` e `install.sh`                                 | Instaladores de la casa, en la raíz del repositorio `respawn-skills` |
| `CHANGELOG.md`                                               | Registro de cambios de la casa, en la raíz del repositorio           |
