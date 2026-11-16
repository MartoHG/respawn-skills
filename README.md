# Respawn Skills

Las reglas de trabajo de **Respawn Informática** para Claude Code: cómo se
releva a un cliente, cómo se diseña, cómo se construye un sitio o un sistema
y cómo se audita antes de entregarlo. Son skills con el estándar abierto
Agent Skills.

Un proyecto que pasa la auditoría sin bloqueantes tiene el sello de la casa.
El sello es una vara interna: no se muestra en la web del cliente
([ADR-002](skills/respawn-skill-creator/adrs/ADR-002-sello-interno.md)).

## Cómo funciona

El sistema tiene dos capas
([ADR-001](skills/respawn-skill-creator/adrs/ADR-001-dos-capas-casa-y-proyecto.md)):

- **La casa**, este repositorio: las reglas, iguales para todo proyecto.
- **El proyecto**, el repositorio de cada cliente: una copia de las skills en
  `.claude/skills/` y su memoria en `.ai/`, con el brief, las decisiones, la
  deuda y el estado.

Solo `respawn-init` se instala en la máquina. Las demás skills llegan a cada
proyecto como copia: así el repositorio del cliente funciona en cualquier
computadora y las skills no aparecen en proyectos ajenos a Respawn
([ADR-007](skills/respawn-skill-creator/adrs/ADR-007-copia-en-el-proyecto-con-respawn-init.md),
[ADR-008](skills/respawn-skill-creator/adrs/ADR-008-disparo-acotado-por-presencia.md)).

El stack lo decide si el proyecto lleva backend: sin backend, Astro con CSS
plano; con backend, Laravel, Blade, Tailwind y HTMX
([ADR-003](skills/respawn-skill-creator/adrs/ADR-003-stack-de-la-casa.md)).

## Instalar

Una vez por máquina:

```bash
git clone https://github.com/MartoHG/respawn-skills
cd respawn-skills
bash install.sh
```

En Windows, el último paso es `.\install.ps1`, sin permisos de
administrador. El instalador hace dos cosas:

- Enlaza `respawn-init` en la carpeta global de skills de Claude Code.
- Enlaza `skills/` como `.claude/skills` dentro de este repositorio, para que
  todas las skills estén activas al trabajar en la casa.

Después de instalar, reiniciar Claude Code. Si el repositorio se mueve de
carpeta, los enlaces se rompen: hay que correr el instalador de nuevo.

## Usar en un proyecto

1. Abrir Claude Code en la carpeta del proyecto y pedir «inicializá este
   proyecto como Respawn». `respawn-init` copia las skills, arma `.ai/` y el
   `CLAUDE.md`.
2. Trabajar por etapas, con la skill de cada una:

| Etapa        | Skill                                        | Qué deja                                         |
| ------------ | -------------------------------------------- | ------------------------------------------------ |
| Relevamiento | `respawn-kickoff`                            | Brief, paquete, alcance y stack                  |
| Diseño       | `respawn-design`                             | Concepto, pantallas y textos                     |
| Construcción | `respawn-web` y, con backend, `respawn-sistemas` | El sitio o el sistema                        |
| Auditoría    | `review-respawn`                             | El informe y, sin bloqueantes, el sello          |

`respawn-proyecto` acompaña todas las etapas: registra las decisiones, la
deuda, los pendientes del cliente y el estado.

Para llevar a un proyecto la versión nueva de la casa, pedir «actualizá las
skills de Respawn de este proyecto». `respawn-init` reemplaza la copia de las
skills y no toca `.ai/`.

## Skills

| Skill                                                          | Para qué                                                                   |
| -------------------------------------------------------------- | -------------------------------------------------------------------------- |
| [respawn-init](skills/respawn-init/SKILL.md)                   | Inicializar o actualizar un proyecto Respawn                               |
| [respawn-kickoff](skills/respawn-kickoff/SKILL.md)             | Relevar al cliente, encuadrar el paquete, fijar el alcance y estimar       |
| [respawn-proyecto](skills/respawn-proyecto/SKILL.md)           | Mantener la memoria del proyecto en `.ai/`                                 |
| [respawn-design](skills/respawn-design/SKILL.md)               | Concepto, pantallas, textos y pasada contra el catálogo de slop            |
| [respawn-web](skills/respawn-web/SKILL.md)                     | HTML, accesibilidad, rendimiento, SEO local, indexación y contacto         |
| [respawn-sistemas](skills/respawn-sistemas/SKILL.md)           | Paneles, tiendas y sistemas en Laravel, con Mercado Pago y operación       |
| [review-respawn](skills/review-respawn/SKILL.md)               | Auditoría de entrega y sello                                               |
| [respawn-skill-creator](skills/respawn-skill-creator/SKILL.md) | Crear y modificar las skills y los ADRs de la casa                         |

## Modificar la casa

- Se trabaja con Claude Code abierto en este repositorio: las skills quedan
  activas por el enlace del instalador.
- Toda skill nueva o modificada pasa por `respawn-skill-creator` y se
  verifica a mano con su lista
  ([ADR-010](skills/respawn-skill-creator/adrs/ADR-010-verificacion-manual.md)).
- Cada cambio se anota en [CHANGELOG.md](CHANGELOG.md). Un proyecto lo
  recibe recién cuando se le corre `respawn-init` otra vez.

## Estructura

```
respawn-skills/
├── skills/          ← una carpeta por skill; los ADRs, en respawn-skill-creator/adrs/
├── install.sh       ← instalador para Linux
├── install.ps1      ← instalador para Windows
├── CHANGELOG.md     ← cambios por versión
├── DECISIONES.md    ← resumen de lo decidido
└── README.md
```

## Decisiones

[DECISIONES.md](DECISIONES.md) resume cada decisión del sistema en una línea.
El porqué completo está en los ADRs, cuyo índice es
[skills/respawn-skill-creator/adrs/README.md](skills/respawn-skill-creator/adrs/README.md).
