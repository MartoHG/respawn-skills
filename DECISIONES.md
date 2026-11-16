# Decisiones de la casa

Resumen de lo decidido en el sistema `respawn-*`, una línea por decisión. El
porqué completo está en cada ADR; la regla, en la skill que figura en la
columna «Dónde». Si una línea de este archivo y su fuente no coinciden, vale
la fuente.

## Estructura del sistema

| Decisión                                                                                   | Dónde                                                                                      |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| Dos capas: la casa dice cómo se decide y el proyecto guarda qué se decidió                 | [ADR-001](skills/respawn-skill-creator/adrs/ADR-001-dos-capas-casa-y-proyecto.md)          |
| La casa es pública: sin precios, clientes, credenciales ni texto copiado                   | [ADR-004](skills/respawn-skill-creator/adrs/ADR-004-repositorio-publico.md)                |
| Los ADRs de la casa viven dentro de `respawn-skill-creator`                                | [ADR-006](skills/respawn-skill-creator/adrs/ADR-006-adrs-dentro-de-skill-creator.md)       |
| Solo `respawn-init` se instala en la máquina; las demás skills se copian a cada proyecto   | [ADR-007](skills/respawn-skill-creator/adrs/ADR-007-copia-en-el-proyecto-con-respawn-init.md) |
| Las skills de la casa existen solo en los proyectos Respawn y en la casa                   | [ADR-008](skills/respawn-skill-creator/adrs/ADR-008-disparo-acotado-por-presencia.md)      |
| `ADR-NNN` en la casa y `ADR-P-NNN` en el proyecto                                          | [ADR-009](skills/respawn-skill-creator/adrs/ADR-009-numeracion-de-adrs.md)                 |
| Las skills se verifican a mano con su lista, sin script de validación                      | [ADR-010](skills/respawn-skill-creator/adrs/ADR-010-verificacion-manual.md)                |
| La memoria de cada proyecto vive en archivos de formato fijo dentro de su `.ai/`           | [ADR-013](skills/respawn-skill-creator/adrs/ADR-013-memoria-del-proyecto-en-inventarios.md) |

## Stack

| Decisión                                                                                   | Dónde                                                                                      |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| Sin backend: Astro con CSS plano. Con backend: Laravel, Blade, Tailwind y HTMX             | [ADR-003](skills/respawn-skill-creator/adrs/ADR-003-stack-de-la-casa.md)                   |
| Roles y permisos con spatie/laravel-permission solo cuando hay dos o más roles             | [respawn-sistemas](skills/respawn-sistemas/SKILL.md)                                       |

## Relevamiento y alcance

| Decisión                                                                                   | Dónde                                                                                      |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| Los paquetes y los precios no se escriben en las skills: se leen de la web de Respawn cada vez | [respawn-kickoff](skills/respawn-kickoff/SKILL.md)                                     |

## Diseño

| Decisión                                                                                   | Dónde                                                                                      |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| Los patrones del catálogo de slop están prohibidos salvo excepción registrada              | [ADR-011](skills/respawn-skill-creator/adrs/ADR-011-slop-prohibido-por-defecto.md)         |
| Una excepción de slop vale si deja de ser cierta al cambiar el cliente por otro de su rubro | [respawn-design](skills/respawn-design/SKILL.md)                                          |
| En un proyecto Respawn manda `respawn-design` sobre las skills de diseño de terceros       | [ADR-012](skills/respawn-skill-creator/adrs/ADR-012-prioridad-sobre-skills-de-terceros.md) |

## Sitios y sistemas

| Decisión                                                                                   | Dónde                                                                                      |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| Indexar es explícito: todo sale con `noindex` salvo que el entorno de producción lo quite  | [respawn-web](skills/respawn-web/SKILL.md)                                                 |
| Un sitio sin backend no lleva formulario: el contacto es el link de WhatsApp               | [respawn-web](skills/respawn-web/SKILL.md)                                                 |
| En el panel, la carga rápida en un diálogo es solo para tareas frecuentes con formularios cortos | [respawn-sistemas](skills/respawn-sistemas/SKILL.md)                                 |
| Con Mercado Pago, el estado del pago se consulta a la API y aplicarlo es idempotente       | [respawn-sistemas](skills/respawn-sistemas/SKILL.md)                                       |

## Auditoría y entrega

| Decisión                                                                                   | Dónde                                                                                      |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| El sello es interno: pasar la auditoría sin bloqueantes, sin crédito en la web del cliente | [ADR-002](skills/respawn-skill-creator/adrs/ADR-002-sello-interno.md)                      |
| Umbrales de la auditoría, medidos en celular en cada página pública                        | [ADR-005](skills/respawn-skill-creator/adrs/ADR-005-umbrales-de-auditoria.md)              |
| Lo bloqueante se comprueba; un riesgo aceptado cubre un bloqueante, salvo los legales      | [ADR-014](skills/respawn-skill-creator/adrs/ADR-014-que-impide-el-sello.md)                |
| Lo legal se audita solo en los sitios que cobran en línea, cualquiera sea el paquete       | [ADR-015](skills/respawn-skill-creator/adrs/ADR-015-legal-solo-en-sitios-que-cobran.md)    |
| Lighthouse lo corre el agente si hay Chrome; si no, el usuario pasa PageSpeed Insights     | [review-respawn](skills/review-respawn/SKILL.md)                                           |
| El informe de auditoría vive en el `.ai/` del proyecto; el del cliente, solo con sello     | [review-respawn](skills/review-respawn/SKILL.md)                                           |
