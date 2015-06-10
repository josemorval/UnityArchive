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

Los vértices de una malla pueden tener más información, además de la evidente, su posición. Entre otros atributos tenemos el **color** del vértice. Si por ejemplo, queremos asignar un color a cada vértice de un quad, bastaría añadir el siguiente script a este objeto

```csharp
	public Color[] colors;

	void Start () {
		Mesh m = GetComponent<MeshFilter>().mesh;
		m.colors = colors;
	}
```

donde el array de colores lo definimos en el inspector de Unity. 

Esta información que definimos en cada vértice puede recogerse en el shader y usarse para colorear la malla. Un shader que hace uso de esto sería el siguiente

```csharp
Shader "Morvaly/VertexColorShader" {
	SubShader {
	    Pass {
	        CGPROGRAM

	        #pragma vertex vert
	        #pragma fragment frag

	        struct appdata {
	            float4 vertex : POSITION;
	            float4 color : COLOR0;
	        };

	        struct v2f {
	            float4 pos : SV_POSITION;
	            float4 col : COLOR0;
	        };
	        
	        v2f vert (appdata v) {
	            v2f o;
	            o.pos = mul( UNITY_MATRIX_MVP, v.vertex );
	            o.col = v.color;
	            return o;
	        }
	        
	        float4 frag(v2f i) : COLOR {
	            return i.col;
	        }
	        
	        ENDCG
	    }
	}
}
```

Vemos dos elementos que no habíamos introducido hasta ahora: las estructuras ```struct```. 

Estas estructuras sirven como **inputs** del vertex shader y del fragment shader. En este caso, lo que _llega al vertex shader desde C#_ es la estructura ```appdata``` que contiene los atributos ```vertex``` y ```color```, definidos en la malla.

Por otro lado, el vertex shader tiene como output otra estructura ```v2f```, que sirve como input para el fragment shader.

##De los vértices a los fragmentos

El vertex shader se ejecuta una vez por vértice de la malla, devolviendo la estructura ```v2f```. Por otro lado el fragment shader tiene como input una estructura del tipo ```v2f```. 

Esto parece un poco raro, ya que el fragment shader se ejecuta una vez por pixel, en el triángulo definido por tres vértices de la malla (no triángulos cualesquiera: triángulos de la **triangulación** de la malla). Entonces, ¿que valor ```v2f``` tomamos para cada pixel? 

La respuesta es: **la interpolación lineal entre los tres** ```v2f```. Es decir, cuando hemos definido el fragment shader como

```csharp
float4 frag(v2f i) : COLOR {
	return i.col;
}
```

el input ```v2f i``` se refiere a la estructura interpolada para ese pixel. 

**Esto mola**. Mola porque para hacer el gradiente que comentábamos al principio basta fijar un color por vértice y dejar que el fragment shader se ocupe del resto, ya que interpolará los colores.

Haciendo esto, se tiene en Unity lo siguiente




