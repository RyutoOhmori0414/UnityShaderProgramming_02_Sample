Shader "Sample/LODFallback"
{
    Properties { }

    SubShader
    {
        // LODは "Level Of Detail" の略
        // 処理速度に応じた処理を、Subshader毎に定義しスイッチできる
        // 高性能な実行環境ではきれいな描画をし、低性能な環境では動くことが優先の荒い処理が行われるとか
        // LOD = 600~100
        // LOD >= 600 赤、400 緑、300 青、
        // それ以下はFullback
        LOD 600

        Tags
        {
            "RenderType" = "Opaque"
        }

        Pass
        {
            CGPROGRAM

            #include "UnityCG.cginc"

            #pragma vertex   vert
            #pragma fragment frag

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
    }

    SubShader
    {
        LOD 400

        Tags
        {
            "RenderType" = "Opaque"
        }

        Pass
        {
            CGPROGRAM

            #include "UnityCG.cginc"

            #pragma vertex   vert
            #pragma fragment frag

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
                return fixed4(0, 1, 0, 1);
            }

            ENDCG
        }
    }

    SubShader
    {
        LOD 300

        Tags
        {
            "RenderType" = "Opaque"
        }

        Pass
        {
            CGPROGRAM

            #include "UnityCG.cginc"

            #pragma vertex   vert
            #pragma fragment frag

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
                return fixed4(0, 0, 1, 1);
            }

            ENDCG
        }
    }

    // FallBackはすべてのSubShaderが有効でないときに、指定したシェーダによって描画が実行される
    // Shader名を指定する。必ず描画できるシェーダを指定する
    FallBack "Sample/Fallback"
    // FallBack "Diffuse"
    // FallBack "VertexLit"
}