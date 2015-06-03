---
published: true
title: Distintas maneras de colorear
layout: post
---



En el post anterior pintamos un cuadrado de color rojo. Recordamos que era tan sencillo como escribir en el fragment shader la línea

```csharp
return float4(1.0, 0.0, 0.0, 1.0); 
```

Pero, ¿y si queremos pintar el mismo cuadrado de varios colores? En particular, ¿cómo podríamos hacer un gradiente de color, de un vértice del cuadrado a su opuesto? 

##Información de los vértices


