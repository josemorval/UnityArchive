Shader "Morvaly/FragmentColorShader" {
SubShader {
    Pass {
        CGPROGRAM

        #pragma vertex vert
        #pragma fragment frag

        struct appdata {
            float4 vertex : POSITION;
            float4 texcoord : TEXCOORD0;
        };

        struct v2f {
            float4 pos : SV_POSITION;
            float4 uv : TEXCOORD0;
        };
        
        v2f vert (appdata v) {
            v2f o;
            o.pos = mul( UNITY_MATRIX_MVP, v.vertex );
            o.uv = float4( v.texcoord.xy, 0, 0 );
            return o;
        }
        
        float4 frag(v2f i) : COLOR {
            
            float4 red = float4(1.0,0.0,0.0,1.0);
            float4 blue = float4(0.0,0.0,1.0,1.0);
            
            float u = i.uv.x;
            float v = i.uv.y;
            
            return lerp(red,blue,0.5*(u+v));
        }
        
        ENDCG
    }
}
}
