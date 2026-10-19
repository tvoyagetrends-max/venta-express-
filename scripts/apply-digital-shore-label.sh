#!/usr/bin/env bash
# Aplica la etiqueta digital-shore.com (y el catálogo opcional) a los repos listados.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LABELS_FILE="${ROOT}/brand/labels/github-labels.yml"
REPOS_FILE="${ROOT}/brand/labels/repos.txt"
DRY_RUN=0
APPLY_ALL=0

usage() {
  cat <<'EOF'
Uso: apply-digital-shore-label.sh [opciones]

  --dry-run     Muestra qué haría sin llamar a la API de escritura
  --all-labels  Crea/actualiza todo el catálogo de github-labels.yml
  -h, --help    Ayuda

Por defecto solo asegura la etiqueta digital-shore.com en cada repo de repos.txt.
Requiere: gh (GitHub CLI) autenticado.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=1; shift ;;
    --all-labels) APPLY_ALL=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Opción desconocida: $1" >&2; usage; exit 1 ;;
  esac
done

if ! command -v gh >/dev/null 2>&1; then
  echo "Error: se necesita GitHub CLI (gh)." >&2
  exit 1
fi

if ! command -v python3 >/dev/null 2>&1; then
  echo "Error: se necesita python3 para leer el YAML." >&2
  exit 1
fi

mapfile -t REPOS < <(grep -vE '^\s*(#|$)' "$REPOS_FILE" | sed 's/[[:space:]]*$//')

if [[ ${#REPOS[@]} -eq 0 ]]; then
  echo "No hay repositorios en $REPOS_FILE" >&2
  exit 1
fi

# Parse labels from YAML into TSV: name<TAB>color<TAB>description
mapfile -t LABEL_ROWS < <(python3 - <<'PY' "$LABELS_FILE" "$APPLY_ALL"
import sys, re
path, apply_all = sys.argv[1], sys.argv[2] == "1"
text = open(path, encoding="utf-8").read()
# Minimal YAML list parser for our simple schema
entries = []
current = {}
for line in text.splitlines():
    if re.match(r"^\s*-\s+name:", line):
        if current.get("name"):
            entries.append(current)
        current = {"name": re.sub(r'^\s*-\s+name:\s*"?([^"]+)"?\s*$', r"\1", line)}
    elif re.match(r"^\s+color:", line):
        current["color"] = re.sub(r'^\s+color:\s*"?([^"]+)"?\s*$', r"\1", line)
    elif re.match(r"^\s+description:", line):
        current["description"] = re.sub(r'^\s+description:\s*"?([^"]*)"?\s*$', r"\1", line)
if current.get("name"):
    entries.append(current)
if not apply_all:
    entries = [e for e in entries if e["name"] == "digital-shore.com"]
for e in entries:
    print(f"{e['name']}\t{e.get('color','0A4D68')}\t{e.get('description','')}")
PY
)

if [[ ${#LABEL_ROWS[@]} -eq 0 ]]; then
  echo "No se encontraron etiquetas para aplicar." >&2
  exit 1
fi

echo "Repos objetivo: ${#REPOS[@]}"
echo "Etiquetas a asegurar: ${#LABEL_ROWS[@]}"
[[ $DRY_RUN -eq 1 ]] && echo "(modo dry-run)"

ok=0
fail=0

upsert_label() {
  local repo="$1" name="$2" color="$3" desc="$4"
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "  [dry-run] $repo ← $name (#$color)"
    return 0
  fi
  # Try create; if exists, edit
  if gh label create "$name" --repo "$repo" --color "$color" --description "$desc" 2>/dev/null; then
    echo "  creada: $name @ $repo"
    return 0
  fi
  if gh label edit "$name" --repo "$repo" --color "$color" --description "$desc" 2>/dev/null; then
    echo "  actualizada: $name @ $repo"
    return 0
  fi
  echo "  error: no se pudo crear/editar $name en $repo" >&2
  return 1
}

for repo in "${REPOS[@]}"; do
  echo "→ $repo"
  if [[ $DRY_RUN -eq 0 ]]; then
    if ! gh repo view "$repo" >/dev/null 2>&1; then
      echo "  omitido: repo no accesible o no existe"
      ((fail++)) || true
      continue
    fi
  fi
  repo_ok=1
  for row in "${LABEL_ROWS[@]}"; do
    IFS=$'\t' read -r name color desc <<<"$row"
    if ! upsert_label "$repo" "$name" "$color" "$desc"; then
      repo_ok=0
    fi
  done
  if [[ $repo_ok -eq 1 ]]; then
    ((ok++)) || true
  else
    ((fail++)) || true
  fi
done

echo
echo "Listo. ok=$ok fail=$fail"
[[ $fail -eq 0 ]]
