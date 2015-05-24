---
layout: post
title: Pintando un cuadro
published: true
---



Las cosas en Unity se pintan usando [shaders](http://en.wikipedia.org/wiki/Shader): pequeños programas que le dicen a la tarjeta gráfica cómo pintar las cosas en la pantalla. 

Estos programas se pueden escribir en distintos lenguajes ([GLSL](http://en.wikipedia.org/wiki/OpenGL_Shading_Language), [HLSL](http://en.wikipedia.org/wiki/High-Level_Shading_Language), etc...), y en el caso particular de Unity se usa [Cg](http://en.wikipedia.org/wiki/Cg_\(programming_language\)), como lenguaje de gráficos estándar.

Los shaders se clasifican en dos tipos _básicos_: los [vertex](https://www.opengl.org/wiki/Vertex_Shader) y los [fragment](https://www.opengl.org/wiki/Fragment_Shader). Para aprender sobre este tema en profundidad os recomiendo [esta página](http://duriansoftware.com/joe/An-intro-to-modern-OpenGL.-Chapter-2.2:-Shaders.html), en la que se hace una gran introducción del funcionamiento de estos programas.

A nosotros nos basta saber que los _vertex programs_ trabajan con la información geométrica del objeto que queremos pintar (los vértices, entre otras cosas) y los _fragment programs_ colorean los triángulos que forman esos vértices, básicamente.

Un ejemplo básico de **vertex shader** sería

```c
float4 vert(float4 vertexPos : POSITION) : SV_POSITION
{
	return mul(UNITY_MATRIX_MVP, vertexPos);
}
```
Este programa coge la posición ```vertexPos``` de los vértices del objeto y devuelve la posición en la pantalla, usando la matriz ```UNITY_MATRIX_MVP```.

Por otro lado, un ejemplo de **fragment shader** podría ser

```c
float4 frag() : COLOR
{
	return float4(1.0, 0.0, 0.0, 1.0); 
}
```

Este programa pintaría el triángulo, sobre el que esté actuando, de color ```rgb(1.0,0.0,0.0)``` rojo. La última componente del ```float4``` se corresponde con la información de transparencia, que trataremos en otro post.

##Vamos a lo práctico: llevando esto a Unity

Abrimos un nuevo proyecto en Unity 

![_config.yml]({{ site.baseurl }}/images/config.png)

