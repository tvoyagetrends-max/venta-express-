# Digital Shore — Etiqueta de marca

**Marca:** Digital Shore  
**Dominio:** [digital-shore.com](https://digital-shore.com)  
**Etiqueta GitHub:** `digital-shore.com`  
**DNS / hosting web:** Cloudflare DNS → Whop (ver [dns/CLOUDFLARE-WHOP.md](./dns/CLOUDFLARE-WHOP.md))

## Propósito

La etiqueta `digital-shore.com` identifica proyectos, issues y pull requests que forman parte del ecosistema Digital Shore: presencia digital, comercio y experiencias web para marcas.

## Identidad visual

| Token            | Valor       | Uso                                      |
|------------------|-------------|------------------------------------------|
| Primary Deep     | `#0A4D68`   | Color de la etiqueta GitHub, mar profundo |
| Primary Ocean    | `#088395`   | Acentos, enlaces, CTAs                    |
| Tide             | `#05BFDB`   | Resaltes y estados hover                  |
| Foam             | `#E8F7FC`   | Fondos suaves                             |
| Ink              | `#0B1F2A`   | Texto principal                           |
| Sand             | `#F4F1EA`   | Superficies secundarias                   |

### Tipografía sugerida

- **Display / logo:** Inter, system-ui, sans-serif (peso 700)
- **Cuerpo:** Inter, system-ui, sans-serif (peso 400–500)

### Tono de voz

Claro, costero y confiable: tecnología accesible con calma de orilla. Mensajes cortos, verbos de acción y cero jerga innecesaria.

## Definición de la etiqueta GitHub

```yaml
name: digital-shore.com
color: "0A4D68"
description: "Ecosistema Digital Shore — digital-shore.com"
```

## Archivos de esta carpeta

| Archivo | Descripción |
|---------|-------------|
| `labels/digital-shore.svg` | Badge / etiqueta visual (SVG) |
| `labels/digital-shore-lockup.svg` | Lockup de marca horizontal |
| `labels/github-labels.yml` | Catálogo de etiquetas (incluye digital-shore.com) |
| `labels/repos.txt` | Lista de repositorios objetivo |
| `dns/CLOUDFLARE-WHOP.md` | Guía: apuntar digital-shore a Whop en Cloudflare |
| `dns/CHECKLIST.md` | Checklist corto de la migración DNS |
| `dns/records.example.yml` | Plantilla de registros DNS (rellenar con valores de Whop) |

## Cómo aplicar la etiqueta

Desde la raíz del repo:

```bash
# Vista previa (no escribe)
./scripts/apply-digital-shore-label.sh --dry-run

# Crear/actualizar la etiqueta en los repos de brand/labels/repos.txt
./scripts/apply-digital-shore-label.sh
```

Requisitos: [GitHub CLI](https://cli.github.com/) autenticado (`gh auth login`) con permiso para administrar etiquetas en cada repositorio.

## Uso en issues y PRs

- Añade `digital-shore.com` a issues/PRs del ecosistema Digital Shore.
- Combínala con etiquetas de tipo (`bug`, `enhancement`, etc.) sin sustituirlas.
- En READMEs, incluye el badge:

```markdown
[![digital-shore.com](./brand/labels/digital-shore.svg)](https://digital-shore.com)
```
