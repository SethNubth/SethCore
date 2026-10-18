# -ADDON-SethCore-V1.0-Safe---Angel-Edition---Optimized-WotLK-Universal-DXVK-Ready-
Addons WoLK 3.3.5 Naerzone...
Hola comunidad de Naerzone!

Les presento SethCore V1.0 Safe - Angel Edition, un addon 100% Lua, seguro y ligero, hecho para mejorar los FPS en WotLK 3.3.5a sin usar DLLs ni programas externos.

Compatible 100% con DXVK v4.4.0 (autorizado por MJ)

CARACTERÍSTICAS PRINCIPALES:
✔ 100% Lua - No baneable, no inyecciones
✔ Para todo tipo de PC (gama baja, media y alta)
✔ Multilenguaje: Español, English US, Português BR
✔ Ligero, no consume memoria

OPTIMIZACIÓN INTELIGENTE:
- Auto GC (limpieza de Lua) cada 45s - Nunca en combate para no dar lag
- Boost Automático de FPS en zonas pesadas:
  > Ciudad: Dalaran
  > Raids: ICC, Sagrario Rubí (SR), Cámara de Archavon (VoA), Trial of the Crusader (TOC), Ulduar
  > BGs masivas: Conquista del Invierno, Bosque Canto de Cristal
- En estas zonas baja automáticamente sombras y hierba, al salir las restaura

COMANDOS:
/sethcore o /sc - Muestra ayuda
/sethcore gc - Limpiar memoria manualmente
/sethcore low / high - Forzar modo bajo o alto FPS
/sethcore info - Ver estado de memoria y modo actual

INSTALACIÓN:
1. Descargar el .zip
2. Extraer la carpeta SethCore en Interface/AddOns/
3. Si usas DXVK, poner el d3d9.dll en la carpeta del WoW (donde está Wow.exe)
4. Activar el addon en la pantalla de personajes

REQUISITOS:
Cliente 3.3.5a (12340) - Sirve para Naerzone y cualquier servidor WotLK.

Autor: Sethnubth - Angel Edition
Version: 1.0-SAFE-Angel-Universal-US-DXVK

Probado en Dalaran con 200 jugadores, de 15 FPS a 35 FPS estables.

¡Feedback y sugerencias bienvenidas!

Descarga: https://github.com/SethNubth/-ADDON-SethCore-V1.0-Safe---Angel-Edition---Optimized-WotLK-Universal-DXVK-Ready-.git

CONSEJOS EXTRA + MACROS POR GAMA DE PC - RECOMENDADO USAR CON SETHCORE


SethCore ya hace el trabajo automático, pero si quieres exprimir más tu PC, usa estas macros. Crea una macro en /macro y ponla en tu barra.

>>> 1. PC / LAPTOP GAMA BAJA (Integrada, 4GB RAM, GT 710, HD 4000, 900MX, etc) <<<
Ideal para Dalaran, ICC 25 y Conquista de Invierno.
Macro: /Gama Baja FPS MAX
/console shadowLevel 0
/console groundEffectDensity 16
/console groundEffectDist 1
/console farclip 185
/console horizonfarclip 1305
/console groundEffectFade 1
/console detailDoodadAlpha 1
/console M2UseShaders 0
/console weatherDensity 0

Resultado: +15 a +25 FPS en Dalaran.

>>> 2. PC GAMA MEDIA (GTX 750, 1050, i3/i5, 8GB RAM) <<<
Equilibrio entre calidad y FPS. Para Raids y BGs.
Macro: /Gama Media Equilibrado
/console shadowLevel 1
/console groundEffectDensity 40
/console groundEffectDist 110
/console farclip 600
/console horizonfarclip 3000
/console detailDoodadAlpha 75
/console M2UseShaders 1
/console weatherDensity 1

Resultado: Estable 50-60 FPS con buena calidad.

>>> 3. PC GAMA ALTA (GTX 1060+, RTX, 16GB RAM) <<<
Para máximo rendimiento en Streaming o 60+ FPS en todo.
Macro: /Gama Alta Calidad
/console shadowLevel 2
/console groundEffectDensity 64
/console groundEffectDist 140
/console farclip 1000
/console horizonfarclip 8000
/console detailDoodadAlpha 100
/console M2UseShaders 1
/console weatherDensity 2

Resultado: Gráficos al máximo sin caídas con SethCore limpiando memoria.

>>> TIP UNIVERSAL PARA TODOS + DXVK <<<
1. Activa DXVK v4.4.0: Solo pon d3d9.dll y dxgi.dll en la carpeta de tu WoW. Ganas 10-20 FPS extra.
2. En el juego: Sistema > Gráficos > Desactiva Sincronización Vertical.
3. Addons pesados: Si usas Recount/Skada + DBM + ElvUI, usa /sethcore gc cada vez que entres a Dalaran o después de un Boss.
4. En RAID: /sethcore low antes de empezar ICC/SR/TOC y /sethcore high al terminar.

Con SethCore + estas macros + DXVK, cualquier tostadora corre WotLK decente.

¡Nos vemos en Dalaran!


