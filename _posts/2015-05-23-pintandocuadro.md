---
layout: post
title: Pintando un cuadro
published: true
---




Las cosas en Unity se pintan usando [shaders](http://en.wikipedia.org/wiki/Shader): pequeños programas que le dicen a la tarjeta gráfica cómo pintar las cosas en la pantalla. Estos programas se pueden escribir en distintos lenguajes ([GLSL](http://en.wikipedia.org/wiki/OpenGL_Shading_Language), [HLSL](http://en.wikipedia.org/wiki/High-Level_Shading_Language), etc...) 

Nosotros usaremos [Cg](http://en.wikipedia.org/wiki/Cg_\(programming_language\)), que es el lenguaje adoptado por Unity como estándar. El código que viene a continuación muestra la sintáxis que tiene este lenguaje 

```java
public void Start(){
	return;
}
```

```glsl
  float4 vert(float4 vertexPos : POSITION) : SV_POSITION {
  return mul(UNITY_MATRIX_MVP, vertexPos);
  }
  
  float4 frag() : COLOR {
  return float4(1.0, 0.0, 0.0, 1.0); 
  }
```
