#!/usr/bin/env bash
# Instala la casa en esta máquina (Linux).
#
# - Enlaza respawn-init en la carpeta global de skills, con un enlace simbólico.
# - Deja activas las skills dentro de este repositorio (.claude/skills -> skills).
#
# Se puede correr de nuevo sin problema. En Windows, usar install.ps1.

set -euo pipefail

casa="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd -P)"

enlazar() {
    local destino="$1" origen="$2"
    if [ -e "$destino" ] && [ ! -L "$destino" ]; then
        echo "ERROR: $destino existe y es una carpeta real. No la toco." >&2
        exit 1
    fi
    mkdir -p "$(dirname "$destino")"
    ln -sfn "$origen" "$destino"
    echo "  enlazado $destino -> $origen"
}

enlazar "$HOME/.claude/skills/respawn-init" "$casa/skills/respawn-init"
enlazar "$casa/.claude/skills" "$casa/skills"

echo
echo "Listo. Reiniciar Claude Code para que tome las skills."
