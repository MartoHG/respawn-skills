# Instala la casa en esta máquina (Windows).
#
# - Enlaza respawn-init en la carpeta global de skills, con una junction.
# - Deja activas las skills dentro de este repositorio (.claude/skills -> skills).
#
# Se puede correr de nuevo sin problema. No pide permisos de administrador.

$ErrorActionPreference = 'Stop'
$casa = $PSScriptRoot

function Enlazar([string]$destino, [string]$origen) {
    if (Test-Path -LiteralPath $destino) {
        $item = Get-Item -LiteralPath $destino -Force
        if (-not $item.LinkType) {
            Write-Host "ERROR: $destino existe y es una carpeta real. No la toco."
            exit 1
        }
        # Borra solo el enlace, nunca el contenido al que apunta.
        [System.IO.Directory]::Delete($destino, $false)
    }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $destino) | Out-Null
    New-Item -ItemType Junction -Path $destino -Target $origen | Out-Null
    Write-Host "  enlazado $destino -> $origen"
}

Enlazar (Join-Path $HOME '.claude\skills\respawn-init') (Join-Path $casa 'skills\respawn-init')
Enlazar (Join-Path $casa '.claude\skills') (Join-Path $casa 'skills')

Write-Host ''
Write-Host 'Listo. Reiniciar Claude Code para que tome las skills.'
