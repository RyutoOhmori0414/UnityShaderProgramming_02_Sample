Shader "Sample/Macro"
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
            CGPROGRAM

            #include "UnityCG.cginc"

            #pragma vertex   vert
            #pragma fragment frag

            // #defineは定義されている識別子がソースコード内に見つかるときに
            // それを後に続く文字列に置換する機能を持っている
            // 置換処理、または定義そのものを「マクロ(Macro)」と呼ぶ
            // 定数の様なもの、
            #define RChannel 1
            #define Color float4(RChannel, 0, 0, 1)
            #define PI 3.141592

            // マクロは引数付きの関数も定義できる
            // 下の場合計算結果が戻り値になる
            #define Circumference(r) 2 * PI * r

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

            fixed4 frag(v2f i) : SV_Target
            {
                float r = RChannel;
                float c = Circumference(0.1);

                // RChannelという文字列を置換するため
                // float 1 = 1;
                // という風になりエラーを出力する
                // float RChannel = 1;

                return Color;
            }

            ENDCG
        }
    }
}