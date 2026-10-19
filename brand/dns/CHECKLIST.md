# Checklist rápido — digital-shore.com a Whop (Cloudflare)

Marca cada ítem mientras lo haces. Detalle completo: [CLOUDFLARE-WHOP.md](./CLOUDFLARE-WHOP.md)

## Whop
- [ ] Abrí Settings → Domains
- [ ] Añadí `digital-shore.com` y/o `www.digital-shore.com`
- [ ] Copié el **TXT** de verificación (si aparece)
- [ ] Copié el **CNAME** (name + target)

## Cloudflare → DNS → Records
- [ ] Añadí el TXT de verificación
- [ ] Añadí/edité CNAME `www` → target de Whop
- [ ] Proxy del CNAME en **DNS only** (nube **gris**)
- [ ] (Opcional) CNAME `@` → Whop **o** Redirect 301 de apex → www
- [ ] Eliminé A/AAAA/CNAME viejos del sitio anterior
- [ ] **No** toqué MX / SPF / DKIM de correo sin necesidad

## Comprobar
- [ ] Whop marca el dominio como verificado / activo
- [ ] `https://www.digital-shore.com` carga Whop con HTTPS
- [ ] Correo del dominio sigue llegando
- [ ] Guardé los valores finales en `records.example.yml` (sin secretos de API)

## Si algo falla
- [ ] CNAME en gris (no naranja)
- [ ] Sin typo en TXT
- [ ] Esperé propagación y probé ventana privada
- [ ] Revisé [CLOUDFLARE-WHOP.md](./CLOUDFLARE-WHOP.md) → Problemas frecuentes
