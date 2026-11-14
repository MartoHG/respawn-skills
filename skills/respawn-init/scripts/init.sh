#!/usr/bin/env bash
# Inicializa o actualiza un proyecto Respawn.
#
# Uso: init.sh <carpeta del proyecto>
#
# - Copia las skills de la casa a <proyecto>/.claude/skills/ (reemplaza la copia anterior).
# - Crea el esqueleto de <proyecto>/.ai/ y el CLAUDE.md, solo lo que falta.
# - Anota en el CLAUDE.md la versión de la casa de la que salió la copia.
#
# Nunca pisa un archivo de .ai/ ni un CLAUDE.md existentes, y nunca toca una
# skill que no sea de la casa.

set -euo pipefail
shopt -u patsub_replacement 2>/dev/null || true

fallar() {
    echo "ERROR: $1" >&2
    exit 1
}

# --- Ubicar la casa a partir de la ruta real de este script -----------------

script="$(readlink -f "${BASH_SOURCE[0]}")"
casa="$(cd "$(dirname "$script")/../../.." && pwd -P)"
[ -d "$casa/skills/respawn-proyecto/assets" ] || fallar "no encuentro la casa a partir de $script"

# --- Validar el proyecto ----------------------------------------------------

[ $# -eq 1 ] || fallar "uso: init.sh <carpeta del proyecto>"
[ -d "$1" ] || fallar "la carpeta del proyecto no existe: $1"
proyecto="$(cd "$1" && pwd -P)"

case "$proyecto/" in
    "$casa/"*) fallar "la carpeta indicada es la casa o está dentro de ella: $proyecto" ;;
esac

nombre="$(basename "$proyecto")"
plantillas="$casa/skills/respawn-proyecto/assets"

# --- Versión de la casa: primer encabezado con número del CHANGELOG ---------

version="$(grep -m1 -oE '^## \[[0-9]+\.[0-9]+\.[0-9]+\]' "$casa/CHANGELOG.md" | tr -d '#[] ' || true)"
[ -n "$version" ] || version="sin publicar"

echo "Casa:     $casa (versión $version)"
echo "Proyecto: $proyecto"
echo

# --- 1. Copiar las skills ---------------------------------------------------

destino="$proyecto/.claude/skills"
mkdir -p "$destino"

# Quitar skills de la casa que ya no existen en esta versión.
for vieja in "$destino"/*respawn*/; do
    [ -d "$vieja" ] || continue
    nombre_vieja="$(basename "$vieja")"
    if [ "$nombre_vieja" = "respawn-init" ] || [ ! -d "$casa/skills/$nombre_vieja" ]; then
        rm -rf "${destino:?}/${nombre_vieja:?}"
        echo "  quitada     .claude/skills/$nombre_vieja (ya no es de la casa)"
    fi
done

for origen in "$casa"/skills/*/; do
    skill="$(basename "$origen")"
    [ "$skill" = "respawn-init" ] && continue
    [ -f "$origen/SKILL.md" ] || continue
    if [ -d "$destino/$skill" ]; then
        accion="actualizada"
        rm -rf "${destino:?}/${skill:?}"
    else
        accion="copiada    "
    fi
    cp -R "$origen" "$destino/$skill"
    rm -rf "$destino/$skill/evals"
    echo "  $accion .claude/skills/$skill"
done

# --- 2. Esqueleto de .ai/ (solo lo que falta) -------------------------------

# crear <plantilla> <destino>: copia la plantilla con el nombre del proyecto.
crear() {
    local plantilla="$1" archivo="$2" contenido
    if [ -e "$archivo" ]; then
        echo "  existe      ${archivo#"$proyecto"/}"
        return
    fi
    mkdir -p "$(dirname "$archivo")"
    contenido="$(cat "$plantilla")"
    contenido="${contenido//\{nombre del proyecto\}/$nombre}"
    contenido="${contenido//\{X.Y.Z\}/$version}"
    printf '%s\n' "$contenido" > "$archivo"
    echo "  creado      ${archivo#"$proyecto"/}"
}

echo
crear "$plantillas/brief.md" "$proyecto/.ai/brief.md"
crear "$plantillas/decisiones.md" "$proyecto/.ai/decisiones.md"
crear "$plantillas/estado.md" "$proyecto/.ai/estado.md"
crear "$plantillas/entrega.md" "$proyecto/.ai/entrega.md"

adr="$proyecto/.ai/adrs/ADR-P-001-stack.md"
if ls "$proyecto"/.ai/adrs/ADR-P-001-* >/dev/null 2>&1; then
    echo "  existe      .ai/adrs/ADR-P-001"
else
    crear "$plantillas/ADR-P-NNN.md" "$adr"
    contenido="$(cat "$adr")"
    contenido="${contenido/ADR-P-NNN: \{Título en una línea\}/ADR-P-001: Stack del proyecto}"
    printf '%s\n' "$contenido" > "$adr"
fi

# --- 3. CLAUDE.md -----------------------------------------------------------

claude="$proyecto/CLAUDE.md"
echo
if [ ! -e "$claude" ]; then
    crear "$plantillas/CLAUDE.md" "$claude"
elif grep -q '^# Proyecto Respawn' "$claude"; then
    if grep -q '^Skills de la casa: versión ' "$claude"; then
        contenido="$(sed -E "s/^Skills de la casa: versión .*/Skills de la casa: versión $version/" "$claude")"
        printf '%s\n' "$contenido" > "$claude"
        echo "  actualizado CLAUDE.md (versión $version)"
    else
        echo "  ATENCION    CLAUDE.md tiene la marca pero no la línea de versión: agregarla a mano"
    fi
else
    echo "  ATENCION    CLAUDE.md existe y no es de un proyecto Respawn: no lo toqué."
    echo "              Integrar a mano la plantilla: $plantillas/CLAUDE.md"
fi

echo
echo "Listo. Proyecto en la versión $version de la casa."
