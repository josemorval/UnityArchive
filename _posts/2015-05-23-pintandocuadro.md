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

```csharp
float4 vert(float4 vertexPos : POSITION) : SV_POSITION
{
	return mul(UNITY_MATRIX_MVP, vertexPos);
}
```
Este programa coge la posición ```vertexPos``` de los vértices del objeto y devuelve la posición en la pantalla, usando la matriz ```UNITY_MATRIX_MVP```.

Por otro lado, un ejemplo de **fragment shader** podría ser

```csharp
float4 frag() : COLOR
{
	return float4(1.0, 0.0, 0.0, 1.0); 
}
```

Este programa pintaría el triángulo, sobre el que esté actuando, de color ```rgb(1.0,0.0,0.0)``` rojo. La última componente del ```float4``` se corresponde con la información de transparencia, que trataremos en otro post.

##Vamos a lo práctico: llevando esto a Unity

Abrimos un nuevo proyecto en Unity y creamos dos objetos en nuestra carpeta de **Assets**, un **shader** y un **material**, y arrastrasmos el shader al material (los materiales son, a grandes rasgos, contenedores de shaders). 

Además de lo anterior creamos un **Quad**, una geometría que se compone de dos triángulos los cuales a su vez forman un cuadrado, es decir, la geometría _casi_ más simple que podemos llegar a formar. 

La cámara que tenemos en escena y el quad tienen que quedar configurados de la siguiente manera

![_config.yml]({{ site.baseurl }}/images/basic01.png)

Lo más importante es que el quad tenga asignado el material que acabamos de crear (arrastrando el material al **Inspector** del quad o bien yendo a **Materiales** dentro del **Mesh Renderer** y asignarlo como material.

En la imagen de la izquierda puede verse una esfera roja. Eso es porque ya esta escrito el shader y Unity puede mostrar una previsualización de lo que va a renderizar.

Vamos a escribir el shader. Para ello editamos el (fichero) shader que hemos creado antes y escribimos lo siguiente

```csharp
Shader "Morvaly/BasicShader" { 
   SubShader { 
      Pass {
         CGPROGRAM 
         #pragma vertex vert 
         #pragma fragment frag
 
         float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
         {
            return mul(UNITY_MATRIX_MVP, vertexPos);
         }
 
         float4 frag() : COLOR
         {
            return float4(1.0, 0.0, 0.0, 1.0); 
         }
 
         ENDCG 
      }
   }
}
```

La mayoría de este código lo hemos visto y es lo importante. El resto es la _carcasa_ que usa Unity para entender el shader

- Todo fichero de shader empieza por ```Shader``` seguido, si se quiere, de un nombre.
- Luego definimos los llamados ```Subshader```. En ocasiones es necesario escribir varios Subshader teniendo en consideración la tarjeta gráfica que lo va a ejecutar. Si tu shader produce un efecto especial espectacular que solo puede ejecutarse en un tipo de tarjeta gráfica, es justo añadir para el resto de tarjetas gráficas un efecto más modesto. 
- Por último tenemos las pasadas ```Pass```. Dependiendo del efecto deseado, nuestro shader puede requerir aplicar cierto efecto y posteriormente otro sobre lo renderizado anteriormente.

De todas maneras, para una comprensión completa de este tema, lo mejor es echarle un ojo a la documentación de Unity sobre [esto](http://docs.unity3d.com/460/Documentation/Manual/ShadersOverview.html).

Si guardamos el shader debería verse algo parecido a lo que sigue

![_config.yml]({{ site.baseurl }}/images/basic02.png)

Moviendo el quad que tiene el material asignado, en la pestaña **Scene**, observamos como el renderizado de la escena en la pestaña **Game** cambia acorde este movimiento. Internamente, sabemos lo que esta pasando: los vértices del quad se están moviendo en el espacio, y por tanto los triángulos que generan, y como consecuencia final, la parte que _colorea_ el shader va cambiando.

<iframe src="https://player.vimeo.com/video/43730150" width="500" height="250" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="https://vimeo.com/43730150">Traveling waves 1</a> from <a href="https://vimeo.com/user10482142">jose morval</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

Este ejemplo, aunque es muy simple, deja entrever la potencia que hay detrás de los shader.
