Shader "Sample/MultiCompile"
{
    SubShader
    {
        Pass
        {
            // 「シェーダバリアント(Shader Variant)」は、一つのソースコードから
            // わずかに異なる複数のシェーダプログラミングを生成する仕組み
            CGPROGRAM

            #pragma vertex   vert
            #pragma fragment frag

            // ここで、なにも定義されていないもの、REDが定義されているもの
            // GREENが定義されているもの、BLUEが定義されているもの
            // の4パターンでコンパイルしろということ
            // 
            // ここでは4つのシェーダプログラミングが
            // 1つのマテリアルに紐づけられていることになる
            #pragma multi_compile _ RED GREEN BLUE

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
                // ここでは定義されているマクロによって異なる処理を行わせている
                // #elifで他条件を定義している
                #ifdef RED

                return fixed4(1, 0, 0, 1);

                #elif  GREEN

                return fixed4(0, 1, 0, 1);

                #elif  BLUE

                return fixed4(0, 0, 1, 0);

                #endif

                return fixed4(0, 0, 0, 1);
            }

            ENDCG
        }
    }
}