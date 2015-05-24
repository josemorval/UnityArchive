Shader "DepthShader" {
	
	Properties{
		_step ("Step", Float) = 0.005
		_edgecolor ("Edgecolor", Color) = (1.0,1.0,1.0,1.0)
	}

	SubShader {

	//No esta de mas
	Tags {"Queue" = "Transparent"} 
	
		Pass{
			
			//Hay que decirle al shader como mezclara los pixeles ya pintados con los nuevos que vienen ahora
			//Blending en terminos del alpha (para que haya transparencia)
			Blend SrcAlpha OneMinusSrcAlpha 

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			sampler2D _CameraDepthTexture;
			float _step;
			float4 _edgecolor;
			
			//Pequena implimentacion del operador de Sobel
			float4 SobelOperator(float4 pos, float h){
				
				//Lecturas necesarias de la depth texture
				float d11 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(-h,-h,0.0,0.0))).r);
				float d12 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(0.0,-h,0.0,0.0))).r);
				float d13 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(h,-h,0.0,0.0))).r);
				float d21 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(-h,0.0,0.0,0.0))).r);
				float d22 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(0.0,0.0,0.0,0.0))).r);
				float d23 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(h,0.0,0.0,0.0))).r);
				float d31 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(-h,h,0.0,0.0))).r);
				float d32 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(0.0,h,0.0,0.0))).r);
				float d33 = Linear01Depth (tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(pos + float4(h,h,0.0,0.0))).r);

				//Convolucion operador de Sobel
				//http://en.wikipedia.org/wiki/Sobel_operator
				float G1 = (-d11 -2.0*d21 -d31) + (d13 +2.0*d23 + d33);
				float G2 = (-d11 -2.0*d12 -d13) + (d31 +2.0*d32 + d33);
				
				//Otra opcion de deteccion de bordes: hay mil mejores, pero "mejor" normalmente implica mas lecturas de la depth texture
				//http://docs.opencv.org/doc/tutorials/imgproc/imgtrans/sobel_derivatives/sobel_derivatives.html
				//float G1 = (-3.0*d11 -10.0*d21 -3.0*d31) + (3.0*d13 +10.0*d23 + 3.0*d33);
				//float G2 = (-3.0*d11 -10.0*d12 -3.0*d13) + (3.0*d31 +10.0*d32 + 3.0*d33);
				
				//"Normalizacion" de la convolucion
				G1/=9.0;
				G2/=9.0;
						
				//Norma de la "derivada" calculada: a mayor magnitud, mayor variacion		
				float r = sqrt(G1*G1+G2*G2);
				
				//Condicion magica: salpimentar al gusto (r esta entre 0 y 1, ya que la depth texture solo tiene valores entre 0 y 1);
				//Si hay variacion grande pintamos blanco opaco, en otro caso negro transparente.
				if(r>0.1){
					return float4(1.0,1.0,1.0,1.0);
				}else{
					return float4(0.0,0.0,0.0,0.0);
				}
					 
			}

			struct v2f {
				float4 pos : SV_POSITION;
				float4 scrPos:TEXCOORD1;
			};

			//Vertex Shader
			v2f vert (appdata_base v){
				v2f o;
				o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
				o.scrPos=ComputeScreenPos(o.pos);
				return o;
			}

			//Fragment Shader
			float4 frag (v2f i) : COLOR{

				return _edgecolor * SobelOperator(i.scrPos, _step);

			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}