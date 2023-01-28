Shader "Atodeyaru/NightShader"
{
    Properties
    {
        _Intensity ("Intensity", float) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Overlay"  "Queue" = "Overlay+9999"}
        LOD 200
        Blend SrcAlpha OneMinusSrcAlpha 

        Pass
        {
            ZTest Always
            Cull Front

            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.uv = v.uv;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            float _Intensity;

            fixed4 frag (v2f i) : SV_Target
            {
				fixed4 c = fixed4(0.0, 0.0, 0.0, _Intensity);

                return c;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}