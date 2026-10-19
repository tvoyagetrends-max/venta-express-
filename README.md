# venta-express-

[![digital-shore.com](./brand/labels/digital-shore.svg)](https://digital-shore.com)

Plataforma de venta inmediata: catálogo, carrito, pagos y pedidos en tiempo real. Rápida, simple y lista para vender.

> Etiqueta de ecosistema: **`digital-shore.com`** — ver [brand/BRAND.md](./brand/BRAND.md)

# Descripción

**Venta Express** es una plataforma de ventas inmediata diseñada para vender productos o servicios de forma rápida y sin fricción. Incluye catálogo de productos, carrito de compras, proceso de pago, gestión de pedidos y notificaciones, todo optimizado para que el cliente compre en pocos clics.

Ideal para negocios que necesitan convertir visitas en ventas al instante.

## Características

- Catálogo de productos con búsqueda y filtros
- Carrito de compras en tiempo real
- Proceso de checkout rápido
- Integración de pagos (Stripe, Mercado Pago, etc.)
- Gestión de pedidos y estados
- Notificaciones (email / WhatsApp)
- Dashboard de administración
- Diseño responsive (móvil primero)
- Modo oscuro / claro

## Tecnologías

- **Frontend**: Next.js / React + TypeScript + Tailwind CSS
- **Backend**: Node.js / API Routes o servidor separado
- **Base de datos**: PostgreSQL / Prisma
- **Pagos**: Stripe
- **Autenticación**: NextAuth / Clerk
- **Despliegue**: Vercel

## Instalación

```bash
# Clonar el repositorio
git clone https://github.com/tvoyagetrends-max/Venta-Express.git
cd Venta-Express

# Instalar dependencias
npm install

# Configurar variables de entorno
cp .env.example .env.local

# Ejecutar en desarrollo
npm run dev
```

## Variables de entorno

```env
DATABASE_URL=
NEXTAUTH_SECRET=
NEXTAUTH_URL=
STRIPE_SECRET_KEY=
STRIPE_PUBLISHABLE_KEY=
```

## Estructura del proyecto

```
src/
├── app/              # App Router (Next.js)
├── components/       # Componentes reutilizables
├── lib/              # Utilidades y configuración
├── prisma/           # Esquema de base de datos
└── public/           # Archivos estáticos
```

## Scripts

```bash
npm run dev          # Servidor de desarrollo
npm run build        # Build de producción
npm run start        # Servidor de producción
npm run lint         # Linter
```

## Etiqueta Digital Shore

Este repositorio forma parte del ecosistema **digital-shore.com**.

| Recurso | Ruta |
|---------|------|
| Guía de marca | [`brand/BRAND.md`](./brand/BRAND.md) |
| Badge SVG | [`brand/labels/digital-shore.svg`](./brand/labels/digital-shore.svg) |
| Lockup SVG | [`brand/labels/digital-shore-lockup.svg`](./brand/labels/digital-shore-lockup.svg) |
| Catálogo de etiquetas GitHub | [`brand/labels/github-labels.yml`](./brand/labels/github-labels.yml) |
| Repos objetivo | [`brand/labels/repos.txt`](./brand/labels/repos.txt) |
| Script de aplicación | [`scripts/apply-digital-shore-label.sh`](./scripts/apply-digital-shore-label.sh) |
| DNS Cloudflare → Whop | [`brand/dns/CLOUDFLARE-WHOP.md`](./brand/dns/CLOUDFLARE-WHOP.md) |
| Checklist DNS | [`brand/dns/CHECKLIST.md`](./brand/dns/CHECKLIST.md) |
| Plantilla registros DNS | [`brand/dns/records.example.yml`](./brand/dns/records.example.yml) |

```bash
# Vista previa
./scripts/apply-digital-shore-label.sh --dry-run

# Crear/actualizar la etiqueta digital-shore.com en los repos listados
./scripts/apply-digital-shore-label.sh
```

Edita `brand/labels/repos.txt` con tus hasta 10 repositorios (`owner/repo`) y ejecuta el script con `gh` autenticado.

### DNS: digital-shore.com en Whop (Cloudflare)

Para apuntar el dominio a Whop **sin salir de Cloudflare**, sigue la guía paso a paso:

1. Abre [`brand/dns/CHECKLIST.md`](./brand/dns/CHECKLIST.md) y ve marcando
2. Detalle completo en [`brand/dns/CLOUDFLARE-WHOP.md`](./brand/dns/CLOUDFLARE-WHOP.md)
3. Regla clave: CNAME hacia Whop con **DNS only** (nube **gris**, no naranja)

> Este agente no puede editar tu cuenta de Cloudflare/Whop. Los cambios DNS los haces tú en el panel (o con tu API token local, nunca en el repo).

## Contribución

1. Fork el proyecto
2. Crea una rama (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -m 'Agrega nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

Marca issues y PRs del ecosistema con la etiqueta **`digital-shore.com`**.

## Licencia

MIT

---

**Venta Express** — Vende ahora.  
Desarrollado por [Voyage Trends](https://github.com/tvoyagetrends-max) · Marca [Digital Shore](https://digital-shore.com)