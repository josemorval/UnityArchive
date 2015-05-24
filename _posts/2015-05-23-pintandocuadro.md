---
layout: post
title: Pintando un cuadro
published: true
---




Las cosas en Unity se pintan usando [shaders](http://en.wikipedia.org/wiki/Shader): pequeños programas que le dicen a la tarjeta gráfica cómo pintar las cosas en la pantalla. 

Estos programas se pueden escribir en distintos lenguajes ([GLSL](http://en.wikipedia.org/wiki/OpenGL_Shading_Language), [HLSL](http://en.wikipedia.org/wiki/High-Level_Shading_Language), etc...), y en el caso particular de Unity se usa [Cg](http://en.wikipedia.org/wiki/Cg_\(programming_language\)), como lenguaje de gráficos estándar.

Los shaders se clasifican en dos tipos _básicos_: los [vertex](https://www.opengl.org/wiki/Vertex_Shader) y los [fragment](https://www.opengl.org/wiki/Fragment_Shader). Para aprender sobre este tema en profundidad os recomiendo [esta página](http://duriansoftware.com/joe/An-intro-to-modern-OpenGL.-Chapter-2.2:-Shaders.html), en la que se hace una gran introducción del funcionamiento de estos programas.

A nosotros nos basta saber que los _vertex programs_ trabajan con la información geométrica del objeto sobre el que queramos pintar y los _fragment programs_ pintan triángulos, básicamente.

Un ejemplo básico de vertex shader sería
```c
float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
{
	return mul(UNITY_MATRIX_MVP, vertexPos);
}
```
