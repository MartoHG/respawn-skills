# Continuar: traspaso de la sesión de construcción

> Memoria de trabajo para retomar desde otra computadora. Resume la charla
> completa de la sesión 2026-11: qué se pidió, qué se investigó, qué se
> decidió, qué quedó escrito, qué se probó y qué falta. Es un documento
> temporal: cuando el trabajo termine se borra, y antes de hacer público el
> repositorio se revisa (ADR-004).

## Contenido

1. Cómo retomar en otra computadora
2. Qué se pidió
3. Estado actual
4. Lo que falta, en orden
5. Decisiones tomadas
6. Cómo trabaja Marto
7. Lo investigado
8. Lo que no se verificó
9. Cronología de la charla

---

## 1. Cómo retomar en otra computadora

1. **Clonar** el repositorio: `https://github.com/MartoHG/respawn-skills`
   (privado por ahora).
2. **Instalar la casa** en esa máquina, desde la raíz del repositorio:
   `.\install.ps1` en Windows o `bash install.sh` en Linux. Enlaza
   `respawn-init` en la carpeta global de skills y deja activas las skills
   dentro del repositorio. Reiniciar Claude Code después.
3. **Abrir Claude Code** en la carpeta del repositorio y pedir: «Leé
   `CONTINUAR.md` y seguí con `review-respawn`».
4. **Leer en este orden** lo que el agente tiene que conocer:
   `CONTINUAR.md`, `skills/respawn-skill-creator/SKILL.md` (el estándar),
   `skills/respawn-skill-creator/adrs/README.md` y las dos o tres skills
   vecinas de la que se escribe.

**Material de referencia que vive en la computadora original** y que quizá no
esté en la otra. Si falta, se clona desde GitHub o se le pide a Marto:

| Qué                                                       | Dónde estaba                              | Para qué sirvió                                       |
| --------------------------------------------------------- | ----------------------------------------- | ----------------------------------------------------- |
| Sistema de skills de Senda, versión actual                | Carpeta `senda`, su `.ai/`                | Modelo del estándar, la lista A a G, `review-senda`   |
| Sistema de skills de Senda, versión publicada             | `github.com/MartoHG/laravel-htmx-patterns` | La misma idea, más vieja                             |
| Web de Respawn                                            | Carpeta `respawn` (`MartoHG/respawn`)     | Brief, decisiones, SEO y la prueba final             |
| Tienda de El Refugio                                      | Carpeta `webshop_laravel`                 | Flujo de Mercado Pago y convenciones de Laravel       |
| Skills de terceros de diseño                              | Carpeta global de skills de Claude Code   | Fuente del catálogo de slop                           |

- Senda no es de Respawn: es del grupo y tiene sus propias skills
  (`senda-*`). Las `respawn-*` no se pisan con esas.
- Un script descartable de verificación mecánica se usó en la sesión y no se
  guardó (ADR-010). Hacía: largo de `SKILL.md`, índice contra secciones,
  `name` igual a la carpeta, largo de la `description`, consultas de
  activación, enlaces rotos, `CRLF`, palabras bloqueadas, IDs de reglas fuera
  de su lista y ADRs citados inexistentes. Se reescribe en unos minutos si
  hace falta; si el mismo error mecánico se repite dos veces, vale la pena
  guardarlo.

---

## 2. Qué se pidió

Marto (Martiniano Gavotti, analista de sistemas y desarrollador full-stack
en Olavarría, de Laravel y PHP; usa Tailwind y HTMX) pidió armar el sistema de
skills `respawn-*` de **Respawn Informática**: servicio técnico de PC y
desarrollo de webs y sistemas para negocios. Funciona como sello de calidad
de todo lo que se haga.

- **Antecedente:** el sistema `senda-*` de Senda (skills, guidelines y ADRs).
  Se quería lo mismo, adaptado a que acá hay muchos proyectos con stacks
  distintos.
- **Dos capas:** la casa (reglas iguales para todos) y el proyecto (lo
  específico de cada cliente).
- **Seis skills pedidas:** `respawn-kickoff`, `respawn-design`,
  `respawn-web`, `respawn-sistemas`, `review-respawn`,
  `respawn-skill-creator`.
- **Reglas del pedido original:** charlar antes de implementar; fases (0
  investigar, 1 decisiones y ADRs, 2 árbol, 3 una skill por vez con revisión,
  4 auditoría, 5 prueba final); lista de tareas visible; YAGNI; no inventar;
  todo en castellano rioplatense con voseo; cada skill con `description`
  acotada, cuerpo de menos de 500 líneas, reglas verificables con su ADR
  citado inline y una sección de antipatrones.
- **Prueba final pedida:** correr `review-respawn` sobre
  `respawninformatica.com.ar` (tiene que pasar; si no, discutir con Marto
  antes de tocar el estándar o la web); simular `respawn-kickoff` con una
  peluquería de Olavarría que pide una landing y a mitad de camino quiere un
  sistema de turnos (tiene que detectar que se sale del paquete); escribir
  `install.sh`, el README y `DECISIONES.md`.

**Lo que se sumó durante la charla:**

- `respawn-kickoff` con el estilo de la skill `grill-me`.
- `respawn-proyecto`: memoria viva de cada proyecto (decisiones, deuda,
  riesgos aceptados, problemas conocidos, pendientes), tomada del modo en que
  Senda lo resuelve hoy.
- `respawn-init`: un comando que inicializa un proyecto y copia las skills
  adentro, para que el repositorio de cada cliente sea autosuficiente.

---

## 3. Estado actual

Siete skills escritas, trece ADRs y los archivos del repositorio.

| Skill                   | Líneas | Qué tiene                                                                                         |
| ----------------------- | ------ | ------------------------------------------------------------------------------------------------- |
| `respawn-skill-creator` | 282    | Estándar, lista A a D, diccionario de idioma, flujo de ADRs, prueba de activación, 13 ADRs         |
| `respawn-proyecto`      | 271    | Formato de la capa proyecto, inventarios, lista A a D y diez plantillas                           |
| `respawn-init`          | 197    | `scripts/init.sh` (inicializa y actualiza) y los instaladores de la raíz                          |
| `respawn-design`        | 298    | Proceso de cinco pasos, catálogo de 111 patrones en ocho categorías, textos, lista A a D           |
| `respawn-web`           | 271    | Lista A a F con 72 reglas, notas para Astro y para Laravel con Blade                              |
| `respawn-sistemas`      | 348    | Lista A a L con 125 reglas, patrones, panel del cliente, Mercado Pago, operación y `puente-htmx.js` |
| `respawn-kickoff`       | 330    | Árbol de relevamiento, estimación por módulos, lista A a D y dos plantillas para el cliente       |
| `review-respawn`        | -      | **Falta escribirla**                                                                              |

Archivos de la raíz: `CHANGELOG.md` (todo bajo «Sin publicar»),
`install.ps1`, `install.sh`, `.gitattributes` (LF salvo `.ps1`) y
`.gitignore`. Todavía no existen `README.md` ni `DECISIONES.md`.

**Estructura de cada skill:** `SKILL.md` con frontmatter, índice numerado,
secciones numeradas desde 0, antipatrones, fuentes y referencias;
`references/` con una `checklist.md` de IDs estables y bloqueantes
declarados; `evals/activacion.json` con la mitad de consultas negativas.

**Cada lista de verificación declara sus bloqueantes.** `review-respawn` las
consume: no reescribe reglas, las recorre.

**Los enlaces rotos que quedan** apuntan a `review-respawn`, que no existe
todavía.

---

## 4. Lo que falta, en orden

### 4.1 Escribir `review-respawn`

Es la auditoría de entrega y el sello (ADR-002). Lo pedido:

- **Entrada:** URL o repositorio, más el paquete contratado. **Salida:** un
  informe `.md` con cada check en ✅, ⚠️ o ❌, con evidencia y cómo arreglarlo,
  separando bloqueantes de recomendaciones. Plantilla en `assets/`.
- **Se verifica mirando y corriendo, no solo leyendo código:** capturas en
  360 px y en escritorio, consola, links rotos. Medir por el DOM, no por la
  captura (Senda lo documenta en su `verificacion-navegador.md`).
- **Áreas:**
    - **Diseño:** pasada contra el catálogo de `respawn-design`; cada patrón
      presente con su excepción en el registro de decisiones.
    - **Técnica:** las listas de `respawn-web` y, con backend,
      `respawn-sistemas`; Lighthouse y accesibilidad con los umbrales del
      ADR-005.
    - **SEO:** `noindex` fuera en producción, canónica, Open Graph, sitemap.
    - **Legal según el paquete:** ver 4.1.1.
    - **Entregables al cliente:** manual del panel, credenciales entregadas de
      forma segura, backups andando con restauración probada, y a nombre de
      quién quedan el dominio y el hosting.
    - **Capa proyecto:** las listas de `respawn-proyecto` y de
      `respawn-kickoff` (brief completo, `ADR-P-001`, pendientes, sin deuda
      alta abierta).
- **Slop Score:** lo corre Marto a mano y pasa el resultado. Es un dato con
  fecha, nunca bloquea ni aprueba por sí solo (ADR-011).
- **Informe para el cliente:** una versión sin jerga, que se entrega como
  parte del trabajo.
- **Pedido en lenguaje natural:** como en `review-senda`, una tabla con el
  valor por omisión de cada parámetro que el pedido no menciona, ejecución sin
  menú previo y anuncio del comando en una línea.
- **Solo lectura** hasta que Marto aprueba el plan de correcciones.
- Lo pospuesto en una auditoría se registra como deuda con `respawn-proyecto`.

#### 4.1.1 Lo legal: lo que se encontró y lo que falta verificar

Se investigó por fuentes secundarias. **Hay que leer el texto en el Boletín
Oficial antes de escribir la skill** y aclarar en ella que no reemplaza
asesoramiento legal.

- **Disposición 954/2025** (Subsecretaría de Defensa del Consumidor,
  septiembre de 2025): deroga las resoluciones 316/2018 y 424/2020.
    - **Botón de arrepentimiento:** enlace llamado «BOTÓN DE ARREPENTIMIENTO»,
      visible a simple vista y en el primer acceso, sin registro previo ni
      trámites adicionales.
    - **Botón de baja:** «BOTÓN DE BAJA DE SERVICIO» (las fuentes difieren en
      singular o plural), con las mismas condiciones.
    - **Plazos:** 10 días corridos para arrepentirse (art. 34 de la Ley
      24.240); código de identificación dentro de las 24 horas; constancia de
      baja sin cargo dentro de las 72 horas.
    - **Atención al cliente:** horario no menor al comercial; si es solo
      telefónica o electrónica, al menos 8 horas diarias de lunes a viernes;
      el sitio informa teléfono o canal y el área responsable.
    - **Excepciones:** productos personalizados, archivos digitales de uso
      inmediato, bienes usados o consumidos, compras para reventa, perecederos;
      se analizan caso por caso.
    - **Sanciones:** las del art. 47 de la Ley 24.240.
- **Disposición 3/2026** (Dirección Nacional de Defensa del Consumidor y
  Arbitraje del Consumo, publicada el 6/2/2026): admite pasos razonables de
  verificación de identidad, y sigue prohibido exigir crear una cuenta. No se
  encontró su texto completo.
- **Ley 25.326** (datos personales): política de privacidad si se juntan
  datos.
- **Fuentes consultadas:**
  [Markco](https://markco.digital/blog/boton-de-arrepentimiento-y-boton-de-baja-que-exige-la-disposicion-9542025),
  [Tavarone](https://tavarone.com/obligatoriedad-de-implementar-el-boton-de-baja-y-el-boton-de-arrepentimiento-en-canales-digitales-comerciales/),
  [Disposición 3/2026 (PDF)](https://www.cabase.org.ar/wp-content/uploads/2026/02/Disposicion-03-26.pdf),
  [Infobae](https://www.infobae.com/economia/2025/09/04/implementaron-cambios-el-regimen-de-cancelacion-de-compras-online/).

### 4.2 `README.md` y `DECISIONES.md`

- `README.md`: qué es, cómo se instala, cómo se usa, tabla de skills (la
  regla de `respawn-skill-creator` exige que coincida con `skills/`).
- `DECISIONES.md`: resumen de todo lo decidido, con enlace a cada ADR.

### 4.3 Auditoría con la lista de `respawn-skill-creator` (fase 4)

- Recorrer la lista completa sobre las ocho skills y los trece ADRs.
- **Correr la prueba de activación**, que no se corrió nunca: juntar las ocho
  `description`, asignar cada consulta de cada `evals/activacion.json` a una
  skill con una sesión nueva o un subagente que no haya participado, y
  ajustar. Riesgo conocido: `respawn-proyecto`, `respawn-kickoff`,
  `respawn-design` y `respawn-init` comparten vocabulario.
- Resolver los enlaces rotos y fijar la versión `0.1.0` en `CHANGELOG.md`
  (`respawn-init` anota esa versión en cada proyecto).

### 4.4 Prueba final (fase 5)

1. **`review-respawn` sobre la web de Respawn.** Tiene que pasar; si no,
   discutirlo con Marto antes de tocar el estándar o la web. Lo que se sabe:
    - Su capa proyecto vive en `docs/` (`brief.md`, `decisiones.md`,
      `seo.md`), no en `.ai/`. Se acordó que `review-respawn` acepte esa ruta
      si el `CLAUDE.md` la declara, sin migrarla. Falta agregarle la línea
      `Proyecto Respawn` y las filas de excepción de slop.
    - **Excepciones de slop probables:** T4 (monoespaciada), C3 (fondo oscuro
      con un acento), E12 (niveles numerados), E13 (etiqueta sobre el título),
      T12 (puntos medios). Las tres primeras salen del concepto arcade.
    - **Slop Score:** el registro de decisiones de la web dice «puntaje 7 %,
      Hecha a mano» (2026-11-03). Marto decidió no cambiar los colores. No se
      pudo medir en la sesión porque antiwebslop pide ingresar con correo para
      una segunda medición.
    - **Lighthouse:** no se midió (la API de PageSpeed respondió 429). El brief
      de la web exige 90 o más en las cuatro categorías.
    - **Posibles hallazgos:** imagen para compartir de 1640 × 624 en lugar de
      1200 × 630 (ya es un pendiente de la web); placeholders y textos en
      borrador por revisar; y todo lo que `respawn-web` exige y la web no
      declare.
2. **Simular `respawn-kickoff`** con la peluquería de Olavarría (landing que
   pasa a querer turnos) y comprobar que frena, lo dice y propone las salidas.
3. **Instalar de verdad:** correr `install.ps1` contra la carpeta global (solo
   se probó su función de enlace en una carpeta temporal) y `install.sh` en
   Linux (solo se comprobó la sintaxis).
4. **Probar `/respawn-init`** sobre una carpeta real y ver que el agente la
   active.

### 4.5 Hacer público el repositorio

ADR-004: público, sin precios ni datos de clientes. Antes: borrar este
archivo, revisar la historia de git y el texto de las skills.

---

## 5. Decisiones tomadas

Los trece ADRs viven en `skills/respawn-skill-creator/adrs/`.

| ADR | Decisión                                                                                              |
| --- | ----------------------------------------------------------------------------------------------------- |
| 001 | Dos capas: la casa dice cómo se decide, el proyecto guarda qué se decidió                              |
| 002 | **El sello es interno:** pasar `review-respawn` sin bloqueantes; no hay crédito visible en la web del cliente |
| 003 | Sin backend: Astro y CSS plano. Con backend: Laravel, Blade, Tailwind y HTMX                           |
| 004 | El repositorio de la casa es público (hoy privado)                                                    |
| 005 | Umbrales de auditoría                                                                                 |
| 006 | Los ADRs de la casa viven dentro de `respawn-skill-creator`                                            |
| 007 | Las skills se copian a cada proyecto con `respawn-init`; solo esa va global                            |
| 008 | Las skills de la casa existen solo en proyectos Respawn                                               |
| 009 | `ADR-NNN` en la casa y `ADR-P-NNN` en el proyecto                                                      |
| 010 | Las skills se verifican a mano con la lista, sin script de validación                                  |
| 011 | Los patrones de slop están prohibidos salvo excepción registrada; los medidores externos no son la vara |
| 012 | En proyectos Respawn manda `respawn-design` sobre las skills de diseño de terceros                     |
| 013 | La memoria del proyecto vive en inventarios dentro de su `.ai/`                                        |

**Umbrales (ADR-005), todos medidos en celular:** Lighthouse rendimiento 90 o
más en sitios sin backend y 80 o más en páginas públicas con backend;
accesibilidad, buenas prácticas y SEO 90 o más; LCP hasta 2,5 s; CLS hasta
0,1; contraste AA; sin errores de consola, sin links rotos y sin
desplazamiento horizontal a 360 px. **Pendiente:** confirmarlos midiendo la
web de Respawn.

**Decisiones que no tienen ADR** (están en las skills):

- **Formularios del panel:** una carga rápida (diálogo) solo si la tarea se
  repite mucho y el formulario es corto; un dato de una fila se cambia en el
  lugar; lo poco frecuente o largo va en página propia. Sin dato de
  frecuencia, página propia. Salió de que a Marto no le gustaba que en Senda
  hasta lo poco frecuente usara modales.
- **Mercado Pago:** el aviso no es la verdad (se consulta la API), aplicar es
  idempotente, el webhook responde enseguida y despacha un job, hay
  conciliación programada y se verifica el importe. Firma comprobada contra la
  documentación oficial: manifiesto `id:{data.id};request-id:{x-request-id};ts:{ts};`
  con HMAC SHA-256, `data.id` en minúsculas.
- **Indexar es explícito:** todo sale con `noindex` salvo que el entorno de
  producción lo quite por una variable.
- **Un sitio sin backend no lleva formulario:** el contacto es el link de
  WhatsApp.
- **Los paquetes y los precios no se escriben en las skills:** la fuente es
  `respawninformatica.com.ar/paginas-web`, y el kickoff la lee cada vez.
- **Prueba de intercambio** para aceptar una excepción de slop: la
  justificación debe dejar de ser cierta al cambiar el cliente por otro de su
  rubro.
- **CSS:** Marto usa CSS plano en landings y sitios sin backend, y Tailwind
  en proyectos Laravel.
- **Spatie permission** solo con dos o más roles.

---

## 6. Cómo trabaja Marto

- **Charla antes de implementar.** Se propone, se critica y se espera el OK.
- **Una skill por vez.** Se la muestra y recién con su «sí, seguí» sigue la
  próxima. Cada entrega termina con qué hay, qué decisiones conviene mirar,
  cómo se verificó y qué no se probó.
- **No se inventa nada** sobre Marto, Respawn o sus proyectos: se pregunta.
- **YAGNI:** nada de dependencias ni secciones por las dudas.
- **Castellano rioplatense con voseo** en todo lo que se escribe.
- **Se pregunta cuando una decisión es suya** (por ejemplo, cuándo usar
  diálogos) y se decide sola cuando es una convención.
- **Sin commits ni subidas por iniciativa propia.** Se hacen cuando él los
  pide.
- Le gustó cómo funcionan las skills de Senda y la skill `grill-me`.
- El sistema de skills de Senda cambió bastante desde el repositorio
  público: tiene scripts orquestadores, evals, riesgos aceptados y deuda con
  formato fijo. Se adoptó la idea y no los scripts (ADR-010).

---

## 7. Lo investigado

### 7.1 Sistema de skills de Senda

- **Estructura:** `.ai/skills/` (seis a siete skills, cada una con `SKILL.md`,
  `references/`, a veces `assets/`, `scripts/` y `evals/`), `.ai/guidelines/`
  (se autocargan) y `.ai/adrs/` (una decisión por archivo, citada inline como
  `*(Ver ADR-NNN)*`). ADR es el porqué; la skill, la regla.
- **`senda-skill-creator`:** estándar de formato, lista A a G con IDs
  estables, diccionario de idioma con voseo, flujo de ADRs, prueba de
  activación con casos límite, sistema de deuda técnica (`DT-NN`) y riesgos
  aceptados (`RA-NN`).
- **`review-senda`:** auditoría por capas de adentro hacia afuera, reuso
  incremental, informe con seis secciones, delegación en subagentes.
- Lo adaptado a Respawn está dicho en cada skill, en su tabla de fuentes.

### 7.2 La web de Respawn

- Cuatro páginas: `/`, `/armado-y-mantenimiento-de-pc`, `/paginas-web`,
  `/trabajos`. Astro, CSS plano con tokens, Cloudflare Pages, concepto arcade
  de 8 bits (Silkscreen y JetBrains Mono, un solo acento verde, sin bordes
  redondeados).
- El link de WhatsApp lleva texto prellenado por servicio.
- Sus documentos (`docs/brief.md`, `contenido.md`, `precios.md`, `seo.md`,
  `decisiones.md`) fueron el modelo de la capa proyecto y de `respawn-web`.
- **Portfolio en su página `/trabajos`:** tienda de El Refugio (Laravel,
  Livewire, Tailwind, Mercado Pago), Senda (Laravel, HTMX, Bootstrap), la
  plataforma legislativa (Laravel, Alpine, Tailwind), un portfolio pixel
  (React, PixiJS) y la propia web.

### 7.3 Catálogo de slop

Se leyeron antiwebslop (unos 130 patrones en ocho categorías), impeccable,
`frontend-design` de Anthropic, `design-taste-frontend`, `emil-design-eng` y
DeSlop. El catálogo de `respawn-design` está escrito con estructura y
palabras propias y cada fuente figura en su tabla.

- `slop-score` de sam-paech **mide texto en inglés generado por modelos**, no
  diseño web: no sirve como vara.
- antiwebslop da un puntaje de 0 a 100 y no publica qué número es verde.

### 7.4 Tienda de El Refugio

Se leyó para generalizar Mercado Pago: verificador de firma, job con
reintentos, aplicación con el pedido bloqueado, comparación de importe y
conciliación. Sus convenciones de nombres (`{singular}_id`, tablas en plural,
`app/Servicios/`, Enums) son las que usa `respawn-sistemas`.

---

## 8. Lo que no se verificó

- **Prueba de activación** de las skills: no se corrió.
- **Plantillas PHP y Blade** de `respawn-sistemas/references/patrones.md`: no
  se corrieron en un proyecto Laravel. Son plantillas con marcadores; la
  primera vez que se usen hay que corregir en la casa lo que no compile.
- **Notas de Laravel** de `respawn-web`: no se probaron en un proyecto real.
- **`install.ps1` completo** contra la carpeta global y **`install.sh`** en
  Linux.
- **El comando `/respawn-init`** a través de Claude Code: el script se probó
  por separado, no la activación de la skill.
- **Normativa legal:** solo por fuentes secundarias.
- **Lighthouse y Slop Score** de la web de Respawn.
- **El puente HTMX** (`respawn-sistemas/assets/puente-htmx.js`) sí se probó
  en el navegador contra un servidor de prueba: carga rápida, errores 422
  junto a cada campo, avisos, 403 y el listado que conserva los filtros.

---

## 9. Cronología de la charla

1. **Pedido y fase 0.** Se leyó el repositorio público de Senda, la web de
   Respawn, las fuentes del catálogo de slop y la normativa. Se plantearon
   cuatro decisiones abiertas y siete más, cada una con recomendación.
2. **Marto aceptó todas las recomendaciones**, con dos cambios: el sello es
   solo una vara interna (sin crédito visible) y el Slop Score no se mide con
   `slop-score` (mide texto), la vara es el catálogo propio.
3. **Stack:** CSS plano sin backend, Tailwind con Laravel. Se preguntó si
   convivían las skills de terceros: manda `respawn-design`.
4. **Carpeta y repositorio:** `respawn-skills` junto a sus otros proyectos,
   con el remoto en GitHub, privado por ahora.
5. **Doce ADRs escritos**, luego se sumó la memoria del proyecto (ADR-013).
6. **Cambio de rumbo en la instalación:** de enlazar todas las skills a la
   carpeta global, a una sola skill global (`respawn-init`) que copia las
   demás dentro de cada proyecto. Motivo: que el repositorio del cliente
   funcione en cualquier máquina y que las skills no aparezcan en Senda.
   Se reescribieron los ADR 001, 006, 007 y 008.
7. **Sumas por pedido de Marto:** estilo `grill-me` para el kickoff;
   `respawn-proyecto` como memoria del proyecto, tomada de cómo Senda lo
   resuelve hoy (deuda, riesgos, problemas conocidos).
8. **Orden de escritura:** `respawn-skill-creator`, `respawn-proyecto`,
   `respawn-init`, `respawn-design`, `respawn-web`, `respawn-sistemas`,
   `respawn-kickoff`. Cada una se mostró y se aprobó con «sí, seguí».
9. **Durante la escritura:**
    - `respawn-init`: el script se probó en carpetas descartables (vacía, a
      través de una junction, actualización, `CLAUDE.md` ajeno, carpetas
      inválidas).
    - `respawn-design`: se leyeron las skills de terceros instaladas; se
      escribió el catálogo con palabras propias.
    - `respawn-web`: se generalizó lo que ya hace la web de Respawn.
    - `respawn-sistemas`: Marto aclaró cuándo usar modales (según
      frecuencia y carga); se escribió y probó el puente HTMX, que mostró dos
      errores que se corrigieron.
    - `respawn-kickoff`: se ajustó la plantilla del brief y la del
      `CLAUDE.md`.
10. **Cierre de la sesión:** Marto pidió pasar la charla a un `.md`,
    commitear y subir para seguir desde otra computadora. Este archivo es
    ese traspaso.

**Próximo paso exacto:** escribir `review-respawn`.
