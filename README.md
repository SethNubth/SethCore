# 🦜 SethCore V1.1 - Angel Edition | FPS Booster
### 100% Lua - No DLL - No Ban - DXVK Ready - For All PCs

> Creado por **SethNubth** para **WoW Forever 1.60.1 / WotLK 3.3.5a**
> Boot automático en: Dalaran, ICC, Ruby Sanctum, TOC, VoA, Ulduar, BGs

![Version](https://img.shields.io/badge/Version-V1.1%20Safe-blue)
![Interface](https://img.shields.io/badge/Interface-16001%20%2F%203.3.5-green)
![Safe](https://img.shields.io/badge/100%25%20Lua-No%20Ban-success)
![FPS](https://img.shields.io/badge/FPS-%2B20%20~%2040-orange)


📦 Instalación
1. Descarga el Release `SethCore v1.1`
2. Extrae la carpeta `SethCore` Copia a Interface/AddOns/ → Renombra a SethCore (Eliminar -Main) Warcraft\_classic_beta_\Interface\AddOns\`
3. `/reload` en el juego
   
### ✨ ¿Qué hace realmente?

Mucha gente vende "FPS Booster" que no hacen nada. **SethCore SÍ hace:**

1.  **Detección inteligente de zonas pesadas:** Detecta si estás en Dalaran, ICC 25, SR, TOC, VoA, Ulduar o Wintergrasp. Solo ahí activa el boost. Si sales, restaura tus gráficos automáticamente.

2.  **Los 2 cambios que más FPS dan en WotLK:**
    *   `shadowLevel = 0` -> **Desactiva sombras.** Es el setting más pesado del juego. Ganancia: **+15 a +30 FPS**.
    *   `groundEffectDensity = 16` -> **Reduce pasto y flores.** Ganancia: **+5 a +10 FPS**, sin perder calidad visual.

3.  **Limpieza de memoria automática:** Cada cambio de zona ejecuta `collectgarbage()`. WoW Forever tiene fuga de memoria y después de 2 horas te va a 10 FPS. Esto te libera 100-300 MB y evita el bajón.

4.  **100% Seguro:** Solo usa comandos oficiales `SetCVar`. No usa DLL, no inyecta nada. Compatible con DXVK, Windows 10/11, Linux (Proton).

### 💻 Guía por Gama de PC / Laptop - Angel Edition

#### 🔴 GAMA BAJA (Intel HD, i3, 4-8GB RAM, sin gráfica dedicada)
Tu objetivo es 40-60 FPS estables.
**Configuración recomendada del juego:**
*   Resolución: 1280x720 o 1366x768
*   Gráficos: Todo en BAJO, Sombras en BAJO, Partículas en BAJO
*   En SethCore: Siempre `/sethcore low`
**Consejo Extra:**
En video opciones desactiva: `Sincronización Vertical`, `Suavizado de bordes (Multisample x1)`, `Resplandor de Muerte`
Usa este comando en el chat: `/console gxApi "d3d11"` y reinicia. Te da +10 FPS en integradas.

#### 🟡 GAMA MEDIA (GTX 1050/1650, RX 570, i5/R5, 8-16GB RAM)
Tu objetivo es 60-100 FPS.
**Configuración recomendada:**
*   Resolución: 1920x1080
*   Gráficos: Distancia de visión en MEDIO, Sombras en BAJO (SethCore lo hará auto), Detalle de hechizos MEDIO
*   En SethCore: Deja el modo AUTO. Se activa solo en Dalaran/Raids.
**Consejo Extra:**
Activa DXVK si estás en Windows. Te quita el stuttering de Forever. SethCore ya es compatible.

#### 🟢 GAMA ALTA (RTX 2060+, RX 6600+, i7/R7, 16GB+ RAM)
Tu objetivo es 100-200+ FPS.
**Configuración recomendada:**
*   Resolución: 1080p / 1440p
*   Gráficos: Todo en ALTO, pero deja que SethCore baje sombras en Dalaran/ICC.
*   En SethCore: `/sethcore high` en mundo abierto, el addon bajará a low solo en zonas pesadas.
**Consejo Extra:**
Usa `/console maxFPS 0` para quitar el limitador y `/console maxFPSBk 30` para que en segundo plano no te consuma PC.

### 🎮 Macros y Comandos que te Salvan FPS

Pega estas macros en tu juego, te dan FPS extra instantáneo:

**Consejo Extra:**
Usa `/console maxFPS 0` para quitar el limitador y `/console maxFPSBk 30` para que en segundo plano no te consuma PC.

🎮 Macros y Comandos que te Salvan FPS

Pega estas macros en tu juego, te dan FPS extra instantáneo:

**1. Macro Anti-Lag para RAIDS (úsala antes de pull):**
/console groundEffectDensity 16
/console groundEffectDist 1
/console particleDensity 10
/console shadowLevel 0
/console textureFilteringMode 0
/cast tus buffs
Te da +40 FPS en ICC 25 con infestación.

**2. Macro para Restaurar Bonito (para fotos / mundo abierto):**
/console groundEffectDensity 256
/console groundEffectDist 140
/console particleDensity 100
/console shadowLevel 2
/console textureFilteringMode 5

**3. Macro Limpia RAM (cuando sientas tirones):**
/run collectgarbage("collect") print("Memoria limpiada!")


⌨️ Comandos
*   `/sethcore` o `/sc` - Muestra ayuda
*   `/sethcore low` - Forzar modo FPS (sin sombras)
*   `/sethcore high` - Restaurar gráficos bonitos
*   `/sethcore gc` - Limpiar memoria RAM ahora mismo

❓ FAQ
**¿Me pueden banear?** No. 100% Lua, usa funciones oficiales de Blizzard.
**¿Funciona en Forever y en 3.3.5a normal?** Sí, es universal.
**¿Por qué solo sombras y pasto?** Porque son los 2 settings que dan 90% de la mejora. Si tocamos view distance se ve feo y la gente se queja.

---
## Cómo mejora FPS SethCore
- Auto-detecta Dalaran / ICC / RS / TOC / VoA
- Desactiva sombras (shadowLevel 0) = +20 FPS
- Reduce pasto (groundEffectDensity 16) = +5 FPS
- Limpia memoria al cambiar de zona
- 100% Lua, sin DLL, sin riesgo de ban
Comandos: /sethcore low / high / gc

