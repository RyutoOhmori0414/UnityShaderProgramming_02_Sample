Shader "Sample/KeywordEnum"
{
    Properties
    {
        // マテリアルのプロパティからキーワードをコンパイルするマクロを切り替えることができる
        // KeyWordEnumはFloatまたはint型に有効な属性です。
        // KeyWordEnumは空のキーワードは定義できない
        [KeywordEnum(Red, Green, Blue)]
        _Color("Color Keyword", Float) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex   vert
            #pragma fragment frag

            // 変数名_引数名がキーワードとなる。変数名_引数名は大文字で定義する
            #pragma multi_compile _COLOR_RED _COLOR_GREEN _COLOR_BLUE

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
                #ifdef _COLOR_RED

                return fixed4(1, 0, 0, 1);

                #elif  _COLOR_GREEN

                return fixed4(0, 1, 0, 1);

                #elif  _COLOR_BLUE

                return fixed4(0, 0, 1, 0);

                #endif

                return fixed4(0, 0, 0, 1);
            }

            ENDCG
        }
    }
}