Shader "Sample/ColorMask"
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
            // RGBA を 0000 の2進数で扱っているため
            // int で指定する際は R = 9 = 1001
            // 白 + Mask R は 1001 ではなく 1XX1
            // でXは計算しないため乗算で白の上でも白になる
            ColorMask R

            // 乗算
            Blend DstColor Zero

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
    }
}