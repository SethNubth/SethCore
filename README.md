# SethCore V1.0 Safe | by SethNubth
### Core Base - Naerzone 30300 - 
# SethCore V1.0 Safe - Angel Edition
Optimized WotLK Universal + DXVK Ready

- FPS Boost en Dalaran, ICC, SR, TOC, VoA, Ulduar, Wintergrasp
- Macros para Gama Baja / Media / Alta
- Compatible D
- 
- Comandos: /sethcore, /sc gc, /sc low, /sc high, /sc info

Creado por Sethnubth para Naerzone 3.3.5

> Librería central segura para todos los addons Seth. Optimizada para gama baja, media y alta.

[Version](https://img.shields.io/badge/Version-1.0%20Safe-blue)
[Interface](https://img.shields.io/badge/Interface-30300%20Naerzone-green)
[Performance](https://img.shields.io/badge/Performance-Low%20to%20High%20End-orange)

---

### ✅ VENTAJAS DE SETHCORE SAFE

**1. Seguridad Naerzone:**
- Solo 1ra cuenta detectada (anti-multi / anti-ninja)
- Protege tu arbitraje en ICC 25H
- `SRA_DB` encriptada por cuenta

**2. Rendimiento Extremo:**
- 0.01ms de uso CPU (core liviano en `core.lua`)
- No usa Ace3 pesado, es puro WoW API
- Carga antes que todos para evitar errores

**3. Texturas Únicas:**
- `agonia_rock.tga` es tu marca, no la tiene nadie más en Naerzone
- 5 texturas pinceladas incluidas, no necesitas SharedMedia

**4. Base para Todo:**
- Si instalas SethCore, todos tus futuros addons (RaidArbiter, SethUI) funcionan automático

---

### ⌨️ COMANDOS DEL ADDON

Comandos principales (funcionan siempre):

| Comando | Descripción |
| :--- | :--- |
| `/sethcore` | Panel info + versión Safe |
| `/sethcore safe` | Verifica estado solo 1ra cuenta |
| `/sethcore media` | Previsualiza tus 5 texturas Agonía |
| `/sethcore reset` | Resetea posición de todo Seth |
| `/sethcore low` | Activa modo bajo consumo (ver abajo) |
| `/sra` | Abre SethRaidArbiter (si lo tienes) |

**Variables guardadas:** `SethCoreDB` y `SRA_DB` en `WTF/Account/`

---

### 💻 RECOMENDACIONES POR PC / LAPTOP

#### 🥔 GAMA BAJA (Toaster, 4GB RAM, Integrada)
Ideal para laptop de colegio o PC vieja en Cajicá con lag en 25H
- Usa: `/sethcore low`
- Esto desactiva: `agonia_splash.tga` y `agonia_retail.tga`
- Deja solo `agonia_rock.tga` (la más liviana - 64x64)
- **FPS:** +10-15 FPS en ICC 25H
- Desactiva en Opciones de Video: Sombras y Brillo a bajo

#### 💻 GAMA MEDIA (8-16GB RAM, GTX 1050 / RX 560)
La mayoría de Naerzone
- Usa configuración normal
- Activa las 5 texturas pinceladas
- `/sethcore` > Activar `Dragonflight UI Compat`
- **Recomendado:** Todo en Alto, pero `SRA_DB` limpiado cada semana con `/sethcore reset`

#### 🚀 GAMA ALTA (16GB+ RAM, RTX 3060+, PC Gamer)
- Activa todo: `/sethcore media` > `Calidad Ultra Pincelada`
- Usa `agonia_splash.tga` de 512x512 para tu botón de minimapa
- Compatible con ElvUI + Dragonflight UI + RayTracing de WotLK
- **Ventaja:** Puedes arbitrar 2 raids a la vez sin lag de addon

---

### 🎮 MACROS RECOMENDADAS (Pega en Juego)

**Macro 1: Arbitraje Rápido (Para ti como árbitro)**


---

### 📥 INSTALACIÓN

1. Descarga ZIP de este repo
2. Renombrar a `SethCore`
3. Poner en `Interface/AddOns/`
4. Encima de `SethRaidArbiter`
5. Entrar y escribir `/sethcore`

6. Aquí los comandos de tu SethCore V1.0 final:

Todos se usan con `/sethcore` o el corto `/sc`

- *`/sethcore`* o *`/sc`* - Muestra la ayuda completa con todos los comandos

- *`/sethcore gc`* - Limpieza manual de memoria Lua. Te dice cuanta memoria quedó. Úsalo al entrar a Dalaran o después de un boss de ICC/SR/TOC.

- *`/sethcore low`* - Fuerza el modo bajo FPS. Quita sombras y hierba al mínimo. Para Dalaran, ICC 25, Conquista del Invierno cuando hay mucha gente.

- *`/sethcore high`* - Fuerza el modo alto. Restaura sombras y hierba. Úsalo cuando salgas de Dalaran o de Raid.

- *`/sethcore info`* - Te muestra: Memoria actual en MB y si el Low Mode está ON/OFF.

*Automáticos (no necesitas escribirlos):*
- Cada 45 segundos hace GC solo si no estás en combate
- Al entrar a Dalaran, ICC, SR, TOC, VoA, Ulduar, Wintergrasp activa solo el modo low automáticamente

**Repo:** https://github.com/SethNubth/-ADDON-SethCore-V1.0-Safe

**By SethNubth - Naerzone - Cajicá - Agonía de Roca Fría 2026**
