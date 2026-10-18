# SethCore V1.1 Safe Universal | by SethNubth
### 100% Lua - DXVK Ready - Multi-idioma ES/EN/PT-BR - For All PCs

> Core base seguro para Naerzone 3.3.5a - Optimizado para Dalaran, Raids y BGs

[Version](https://img.shields.io/badge/Version-1.1%20SAFE%20Universal-blue)
[Lua](https://img.shields.io/badge/100%25%20Lua-Safe%20No%20DLL-green)
[DXVK](https://img.shields.io/badge/DXVK-v4.4.0%20Vanilla%20Ready-orange)
[Lang](https://img.shields.io/badge/Lang-ES%20EN%20PT--BR-yellow)

---

### 📜 ¿QUÉ ES?

SethCore es el motor base 100% Lua, sin DLLs ni inyecciones, 100% seguro y no baneable en Naerzone.

Es compatible con **DXVK v4.4.0 Vanilla** (solo d3d9.dll - autorizado).

### ✨ CARACTERÍSTICAS - Lo Establecido

1.  **100% Lua:** No usa `wow-optimize.dll`. No hay riesgo de ban.
2.  **DXVK Ready:** Diseñado para funcionar con DXVK GPLAsync v3.1.1 / Sarek v1.14.0 (versión Vanilla).
3.  **Multi-idioma:** Detecta el idioma de tu cliente WoW automáticamente:
    *   `esES / esMX` -> Español
    *   `enUS` -> English
    *   `ptBR` -> Português (Brasileños)
4.  **Universal - Para Todo Tipo de PC:** No es solo para tu PC, es para todos:
    *   Gama Baja (Toaster / 4GB / Integrada)
    *   Gama Media (8-16GB / GTX 1050)
    *   Gama Alta (RTX)

### 🚀 OPTIMIZACIÓN INTELIGENTE - Boot Automático

El addon detecta automáticamente zonas pesadas y hace boost de FPS:

*   **Ciudad:** Dalaran
*   **Raids:** ICC, Sagrario Rubí (SR), Prueba del Cruzado (TOC), Cámara de Archavon (VoA), Ulduar
*   **BGs Masivas:** Conquista del Invierno, Isla de la Conquista

> En esas zonas baja sombras y hierba automáticamente. Al salir, las restaura. Auto-GC cada 45s (nunca en combate).

### ⌨️ COMANDOS

| Comando | ES | EN | PT-BR |
| :--- | :--- | :--- | :--- |
| `/sethcore` o `/sc` | Muestra ayuda | Show help | Mostra ajuda |
| `/sethcore low` | Forzar modo bajo FPS | Force low FPS mode | Forçar modo low FPS |
| `/sethcore high` | Restaurar gráficos | Restore graphics | Restaurar gráficos |
| `/sethcore gc` | Limpiar memoria Lua | Clean Lua memory | Limpar memória Lua |

### 📥 INSTALACIÓN

1.  Descarga: `Code > Download ZIP` de este repo.
2.  Extrae y renombra a `SethCore`.
3.  Copia a `Interface/AddOns/`.
4.  **Opcional DXVK (Recomendado):** Ver sección abajo.
5.  Activa en la pantalla de personajes.

### 🔗 DXVK RECOMENDADO (Opcional, +15-30 FPS)

Para el boost real de FPS, usa SOLO la versión VANILLA (sin suprepupre).

> **IMPORTANTE:** Para Naerzone / Monster / Warmane usa solo la versión VANILLA. La versión FULL con wow-optimize es baneable según el propio autor suprepupre.

**1. Para PC Gama Media/Alta (Recomendado):**
*   Paquete: `v4.4.0-DXVK-vanilla` - DXVK GPLAsync v3.1.1
*   Repo Oficial: `github.com/Sporif/dxvk-async/releases` o busca `doitsujin/dxvk`
*   Busca el release de suprepupre: `v4.4.0-DXVK-vanilla` en su GitHub
*   De todo el ZIP copia SOLO `x32/d3d9.dll` a tu carpeta de WoW.

**2. Para PC Gama Baja / Toaster (PC Antiguas):**
*   Paquete: `v4.4.0-DXVK-vanilla-(sarek-for-old-pcs)` - DXVK Sarek-async v1.14.0
*   Repo Oficial: `github.com/pythonlover02/DXVK-Sarek/releases`
*   Busca el release de suprepupre: `v4.4.0-DXVK-vanilla-(sarek-for-old-pcs)`
*   De todo el ZIP copia SOLO `x32/d3d9.dll`.

**Instalación DXVK:** Pegar `d3d9.dll` donde está `Wow.exe`. Si hay uno viejo, reemplázalo.
**Desinstalación:** Borra `d3d9.dll`.

### 🔗 COMPATIBILIDAD

*   **Obligatorio para:** `SethRaidArbiter V1.1`
*   **Cliente:** 3.3.5a (12340) - Naerzone / Warmane / Monster (Vanilla mode)
*   **Texturas:** Agonía Roca Fría Pincelada - `Media/agonia_rock.tga`

**By SethNubth - Naerzone - Angel Edition - V1.1 SAFE Universal 2026**
# SethCore V1.1 Safe Universal | by SethNubth

QUE ES? Motor base 100% Lua, sin DLLs, 100% seguro Naerzone. Compatible DXVK v4.4.0 Vanilla.

CARACTERISTICAS: 100% Lua, DXVK Ready, Multi-idioma esES/enUS/ptBR, Universal Gama Baja/Media/Alta.

BOOT AUTOMATICO: Dalaran, Raids ICC/SR/TOC/VoA/Ulduar, BGs Conquista del Invierno.

COMANDOS: /sethcore /sc /sethcore low /sethcore high /sethcore gc

 1' Marcos F1 toaster
 
 /sethcore low
/console groundEffectDensity 16
/console groundEffectDist 1
/console detailDoodadDensityPct 10
/console particleDensity 10
/console shadowMode 0
/console waterDetail 0
/console weatherDensity 0

2' Macro anti Crasheo

/console maxfps 30
/console maxfpsbk 15
/console ffx 0
/console ffxDeath 0
/console ffxGlow 0
/sethcore low

3' 2. CAMBIOS EN WTF/Config.wtf (Cierra el WoW antes):**

Abre `WTF/Config.wtf` con bloc de notas y cambia/agrega esto:
SET shadowLevel "0"
SET groundEffectDensity "16"
SET farclip "400"
SET particleDensity "0.1"
SET waterDetail "0"
SET ffxDeath "0"
SET ffxGlow "0"


Esto hace que el WoW inicie ya optimizado.
