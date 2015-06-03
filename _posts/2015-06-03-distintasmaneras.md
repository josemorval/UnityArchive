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

Vemos dos elementos que no habíamos introducido hasta ahora 






