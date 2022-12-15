Shader "Sample/MultiPass"
{
    Properties { }
    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
        }
        Pass
        {
            // Passは必ず一つの出力を持っている
            // このパスは赤色を出力している

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
                return fixed4(1, 0, 0, 1);
            }

            ENDCG
        }

        Pass
        {
            // このパスは水色を出力している

            // ブレンドのタイプを指定している。
            // Blend One One なので加算合成
            // https://docs.unity3d.com/ja/2019.4/Manual/SL-Blend.html
            // ↑Blendについてのリファレンス
            Blend One One

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

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return fixed4(0, 1, 1, 1);
            }

            ENDCG
        }
    }
}