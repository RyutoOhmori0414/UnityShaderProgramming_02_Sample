﻿Shader "Sample/PerfectTransparentA"
{
    Properties { }
    SubShader
    {
        Tags
        {
            "Queue"      = "Transparent"
            "RenderType" = "Transparent"
        }

        Pass
        {
            // カメラに向いているポリゴンが同一オブジェクト内でも
            // 重なると合成されている
            
            // 半透明なもののリアルな描写には、向いている 

            // ZWriteがオフのためカメラに向いているポリゴンをすべて描画し、
            // 合成している
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM

            #pragma vertex   vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return fixed4(1, 0, 0, 0.5);
            }

            ENDCG
        }
    }
}