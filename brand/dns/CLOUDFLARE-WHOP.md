# Mover DNS de digital-shore a Whop (en Cloudflare)

Guía paso a paso para apuntar **digital-shore.com** a **Whop** usando **Cloudflare** como DNS.

> No necesitas “mover el dominio fuera de Cloudflare”.  
> Cloudflare sigue siendo tu DNS. Solo cambias los **registros** para que el tráfico web vaya a Whop.

---

## Qué vas a lograr

| Antes | Después |
|--------|---------|
| El sitio puede apuntar a otro hosting / página vieja | `digital-shore.com` (y/o `www`) carga tu storefront de Whop |
| DNS gestionado en Cloudflare | Sigue en Cloudflare, con registros de Whop |

---

## Antes de empezar (checklist rápida)

- [ ] Tienes acceso a [Cloudflare](https://dash.cloudflare.com) y ves la zona **digital-shore.com**
- [ ] Tienes acceso al dashboard de [Whop](https://whop.com)
- [ ] El dominio ya usa nameservers de Cloudflare (si no, ver sección final)
- [ ] Anota lo que Whop te pida exactamente (CNAME / TXT). **Esos valores mandan** sobre cualquier ejemplo de esta guía

---

## Paso 1 — Conectar el dominio en Whop

1. Entra a Whop → tu compañía / producto.
2. Busca **Settings → Domains** (o **Custom domain**).
3. Añade el dominio que quieras usar, por ejemplo:
   - `digital-shore.com` (raíz / apex), o
   - `www.digital-shore.com`, o
   - un subdominio tipo `store.digital-shore.com` / `pay.digital-shore.com`
4. Whop te mostrará los registros DNS a publicar. Cópialos tal cual.

Suele pedirte algo como:

| Tipo | Nombre (host) | Valor (contenido / target) | Para qué |
|------|----------------|----------------------------|----------|
| **TXT** | `_whop` o similar | `whop-domain-verification=...` | Probar que eres dueño del dominio |
| **CNAME** | `www` o el subdominio | p. ej. `domains.whop.com` (o el target que muestre Whop) | Enviar el tráfico web a Whop |

> ⚠️ Los nombres y valores **exactos** salen de tu panel de Whop. Si difieren de esta tabla, usa siempre los de Whop.

---

## Paso 2 — Abrir DNS en Cloudflare

1. Entra a [dash.cloudflare.com](https://dash.cloudflare.com)
2. Selecciona el sitio **digital-shore.com**
3. Menú lateral → **DNS** → **Records**

Ahí verás la lista actual (A, CNAME, MX, TXT, etc.).

---

## Paso 3 — Añadir verificación TXT (si Whop la pide)

1. **Add record**
2. **Type:** `TXT`
3. **Name:** el que diga Whop (ej. `_whop` o `@` o un host largo)
4. **Content:** el string completo de verificación
5. **TTL:** Auto
6. **Save**

Los TXT **no** llevan nube naranja; Cloudflare los trata siempre como solo-DNS.

Espera 1–30 minutos (a veces hasta unas horas) y en Whop pulsa **Verify** / espera verificación automática.

---

## Paso 4 — Apuntar el tráfico web a Whop (CNAME)

### Opción A — Subdominio o `www` (recomendado y más simple)

1. **Add record** (o edita el existente)
2. **Type:** `CNAME`
3. **Name:** `www` (o `store`, `pay`, etc.)
4. **Target:** el valor de Whop (a menudo algo como `domains.whop.com`)
5. **Proxy status:** **DNS only** (nube **gris**) ← muy importante
6. **Save**

### Opción B — Dominio raíz `digital-shore.com` (apex)

Cloudflare no permite un CNAME “clásico” en `@` en todos los casos, pero sí **CNAME flattening**:

1. **Add record**
2. **Type:** `CNAME`
3. **Name:** `@`
4. **Target:** el target de Whop
5. **Proxy status:** prueba primero **DNS only** (gris)
6. **Save**

Si ya tienes un registro **A** o **AAAA** en `@`, bórralo o sustitúyelo: no pueden convivir un A y un CNAME en el mismo nombre.

### `www` → raíz o raíz → `www`

En Whop elige **una** URL canónica (ej. `www.digital-shore.com`) y:

- Apunta esa al CNAME de Whop
- En Cloudflare → **Rules** → **Redirect Rules** (o Page Rules) redirige la otra variante con **301**

Ejemplo de idea:

- Canónica: `https://www.digital-shore.com`
- Redirect: `digital-shore.com/*` → `https://www.digital-shore.com/$1`

---

## Paso 5 — Nube naranja vs gris (Cloudflare + Whop)

| Estado | Icono | ¿Usar con Whop? |
|--------|--------|------------------|
| **Proxied** | Nube naranja | Suele **romper** SSL / verificación de host de terceros |
| **DNS only** | Nube gris | **Recomendado** para CNAME hacia Whop |

Regla práctica: **CNAME hacia Whop = DNS only (gris)** hasta que Whop confirme el dominio y el HTTPS funcione.  
Si más adelante Whop documenta soporte con proxy de Cloudflare, puedes reevaluar.

---

## Paso 6 — Limpieza de registros viejos

Revisa y elimina (o desactiva) lo que ya no uses para el sitio web:

- [ ] `A` / `AAAA` antiguos del hosting anterior en `@` o `www`
- [ ] `CNAME` viejos a Vercel, Netlify, Shopify, etc.
- [ ] No toques **MX** ni TXT de **correo** (Google, Microsoft, etc.) salvo que sepas que sobran
- [ ] Conserva SPF/DKIM/DMARC de email si usas correo en ese dominio

---

## Paso 7 — Verificar que funcionó

### En Cloudflare
- DNS → Records: ves el CNAME (gris) y el TXT de verificación

### En la terminal (tu PC)

```bash
# Verificación TXT (ajusta el nombre si Whop usa otro host)
dig TXT _whop.digital-shore.com +short

# CNAME de www
dig CNAME www.digital-shore.com +short

# Resolución final
dig www.digital-shore.com +short
```

### En el navegador
- Abre `https://www.digital-shore.com` (o la URL que configuraste)
- Debe cargar Whop con candado HTTPS
- Si falla, espera propagación (hasta 24–48 h en casos raros; normalmente minutos)

### En Whop
- Estado del dominio: **Verified** / **Active**
- SSL listo

---

## Tabla de ejemplo (plantilla)

Rellena con los valores reales de tu panel Whop. Plantilla YAML: [`records.example.yml`](./records.example.yml).

| Tipo | Name | Content / Target | Proxy | Notas |
|------|------|------------------|-------|-------|
| TXT | `_whop` | `whop-domain-verification=PEGAR_AQUI` | — | Solo si Whop lo pide |
| CNAME | `www` | `domains.whop.com` | DNS only | Sustituye target si Whop da otro |
| CNAME | `@` | `domains.whop.com` | DNS only | Opcional (apex / flattening) |

---

## Problemas frecuentes

### “Pending verification”
- El TXT tiene un typo o el **Name** está mal (a veces Cloudflare ya añade `.digital-shore.com`)
- Aún no propagó: espera y reintenta en Whop
- Caché local: prueba desde [https://dnschecker.org](https://dnschecker.org)

### Error SSL / “too many redirects”
- CNAME en **Proxied (naranja)** → cámbialo a **DNS only**
- Redirects duplicados entre Cloudflare y Whop: deja una sola canónica

### El sitio sigue mostrando la web vieja
- Quedó un registro A/CNAME antiguo
- Navegador en caché: prueba ventana privada
- CDN/caché de Cloudflare: **Caching → Configuration → Purge Everything** (si el proxy estaba activo)

### Correo dejó de funcionar
- Restaurá los **MX** y TXT de email; mover web a Whop **no** requiere borrar el correo

---

## Si el dominio aún NO está en Cloudflare

1. Añade el sitio en Cloudflare (Add a site → `digital-shore.com`)
2. Cloudflare te da 2 nameservers (ej. `ada.ns.cloudflare.com`, `bob.ns.cloudflare.com`)
3. En el **registrador** (Namecheap, GoDaddy, Google Domains, etc.) cambia los nameservers a esos dos
4. Espera a que Cloudflare marque la zona **Active**
5. Luego sigue desde el **Paso 1** de esta guía

Eso sí es “mover el DNS a Cloudflare”. Después, “mover a Whop” = solo los registros de arriba.

---

## Seguridad y buenas prácticas

- No compartas capturas con tokens o verification secrets en chats públicos
- No pongas API tokens de Cloudflare en este repositorio
- Usa 2FA en Cloudflare y Whop
- Documenta en el equipo cuál es la URL canónica (`www` vs apex)

---

## Resumen en una frase

**Cloudflare = DNS. Whop = destino del sitio. CNAME (gris) + TXT de verificación = digital-shore en Whop.**

Cuando tengas los valores exactos del panel de Whop, pégalos en [`records.example.yml`](./records.example.yml) y marca los checklists de esta guía.
