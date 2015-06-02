Shader "Morvaly/VertexColorShader" {
SubShader {
    Pass {
        CGPROGRAM

        #pragma vertex vert
        #pragma fragment frag

        struct appdata {
            float4 vertex : POSITION;
            float4 color : COLOR;
        };

        struct v2f {
            float4 pos : SV_POSITION;
            float4 col : COLOR;
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
