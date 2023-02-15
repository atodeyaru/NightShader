Shader "Atodeyaru/NightShader"
{
    Properties
    {
        _Intensity ("Intensity", float) = 0
    }
    SubShader
    {
        LOD 200
        
        Tags { "RenderType"="Overlay"  "Queue" = "Overlay+9999"}
        Blend SrcAlpha OneMinusSrcAlpha 
        ZTest Always
        
        Pass
        {
            Cull Front

            Stencil{
                Ref 0
                Comp always
            }

            ColorMask 0
        }

        Pass
        {
            Cull Back

            Stencil{
                Ref 1
                Comp always
                Pass replace
            }

            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            
            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
                half depth : TEXCOORD0;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                COMPUTE_EYEDEPTH(o.depth);
                return o;
            }

            float _Intensity;

            fixed4 frag (v2f i) : SV_Target
            {
				fixed4 c = fixed4(0.0, 0.0, 0.0, _Intensity * saturate(1 - i.depth));

                return c;
            }
            ENDCG
        }

        Pass
        {
            Cull Front

            Stencil{
                Ref 1
                Comp notequal
            }

            CGPROGRAM
            #include "UnityCG.cginc"
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            
            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
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