Shader "Sample/MipMap"
{
    // Mipmapはあるテクスチャが用意されるとき、元のテクスチャの解像度よりも
    // 低い解像度のテクスチャを複数用意しておく機能です。
    // あるいはそのテクスチャのあつまりをMipMapと呼びます

    // MipMapが無効だと、特に遠方を描画した際にジャギーが現れ、モアレのような効果も強く見える
    // 有効な場合アンチエイリアスされ、自然な絵に見える

    // 描画するPixelに複数のTexelがある場合に、自然に見せる処理としてアンチエイリアスがあり
    // その処理を描画する際に行うと重くなるため、あらかじめテクスチャに書き込んでおくという処理

    // デメリットは、複数のテクスチャを用意するためメモリサイズが大きくなってしますこと。
    // すべてのテクスチャに用意するべきではない。
    Properties
    {
        [NoScaleOffset]
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque" }

        LOD 100

        Pass
        {
            CGPROGRAM

            #pragma vertex   vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv     : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv     : TEXCOORD0;
            };

            sampler2D _MainTex;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv     = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                return tex2D(_MainTex, i.uv);
            }

            ENDCG
        }
    }
}