Shader "Sample/ShaderFeature"
{
    Properties
    {
        // このシェーダはキーワードの有効無効の組み合わせによって出力結果を変更することができる

        // Toggle属性もFloatとInt型に設定することができる
        // このチェックボックスが、引数に指定したキーワードの有効無効と連動する
        [Toggle(_R)] _R ("R", Float) = 0
        [Toggle(_G)] _G ("G", Float) = 0
        [Toggle(_B)] _B ("B", Float) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM

            #pragma vertex   vert
            #pragma fragment frag
            // キーワードの有効無効を切り替えるため、_ で空を定義する
            #pragma multi_compile _ _R
            #pragma multi_compile _ _G
            #pragma multi_compile _ _B

            // shader_featureはキーワードの無効状態である「_」も自動で定義するため省略することができる
            // そのキーワードが使われていないことが明白である場合、そのキーワードを
            // ビルドに含めません。その判定はマテリアルなどで判定されるため
            // スクリプトから変更を加える際は、注意が必要です
            // #pragma shader_feature _R
            // #pragma shader_feature _G
            // #pragma shader_feature _B

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
                fixed4 color = fixed4(0, 0, 0, 1);

                #ifdef _R
                color.r += 1;
                #endif

                #ifdef _G
                color.g += 1;
                #endif

                #ifdef _B
                color.b += 1;
                #endif

                return color;
            }

            ENDCG
        }
    }
}