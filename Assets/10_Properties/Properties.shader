Shader "Sample/Properties"
{
    Properties
    {
        // Propatiesは、インスペクター上から変更したい値を指定し
        // 変数名("インスペクター上の表記名", 型) = 初期値 です
        // テクスチャなら 2D 型、数値型なら Float 型を使います
        // C#と同じように、[属性名]で属性を設定できる
        // しかし、[属性A, 属性B]とするとBの設定が無効になります

        // HeaderはパラメータUIの直前に太字のラベルを表示することができる。
        // 後に続くパラメータのグループなどを明示的に示せる
        [Header(Texture)]
        
        // テクスチャのプロパティは2Dとして定義するのが基本
                                _MainTex     ("MainTex",     2D) = "white" {}
        // Inspector上にTilingとOffsetのパラメータを表示しないようにする。
        // _ST変数を使わない限り、TilingとOffsetのパラメータは不要
        [NoScaleOffset]         _SubTex      ("SubTex",      2D) = "white" {}
        // [Normal]はnormalマップ以外のテクスチャを指定すると警告がでます
        [Normal][NoScaleOffset] _NormalTex   ("NormalTex",   2D) = "white" {}
        // HDR設定されたテクスチャが設定されることを明示的にします
        [HDR]                   _HDRTex      ("HDRTex",      2D) = "white" {}
        // MaterialPropartyBlockによって値が設定される変数であること明示します
        // Inspector上では非表示になる
        [PerRendererData]       _PerRenderer ("PerRenderer", 2D) = "white" {}

        // Rectは2のべき乗でないテクスチャ用の型です。
        _RectTex ("RectTex", Rect)    = "white" {}
        // Cubeはキューブマップ用の特別なテクスチャの型です。それ以外のテクスチャは指定できません
        _CubeTex ("CubeTex", Cube)    = "white" {}
        // 3Dは3Dテクスチャ用の型です。ボリュームデータなどの3次元のデータを持ったテクスチャのため利用される
        _3DTex   ("3DTex",   3D)      = ""      {}
        // 2DArrayは2次元の配列のデータを持ったテクスチャ用の型です。3Dテクスチャと似ていますが異なります
        _2DArray ("2DArray", 2DArray) = ""      {}

        [Header(Value)]

                         _Float0 ("Float0",    Float)       = 1.0
        // Inspector上の値の範囲を指定する際は、Range(min, max)型を使います。
        // インスペクター上の表記はスライダーになります
                         _Float1 ("Float1",    Range(0, 1)) = 0.5
        // [PowerSlider(n)]は、Range型と合わせて活用します。
        // スライダーによって変化する値がn乗、指数曲線の非線形になります
        [PowerSlider(2)] _Float2 ("PowSlider", Range(0, 1)) = 0.25

        // 直前のパラメータとの間に余白を挿入できる
        [Space]

                   _Int0 ("Int0",     Int)          = 1
        // Int型で値の範囲を指定したいときは、[IntRange]を設定する
        [IntRange] _Int1 ("IntRange", Range(0, 10)) = 1

        // 値を指定して区切ることもできる
        [Space(10)]

        // Color型はインスペクター上で直接色を指定し、そのRGBAを0～1で指定します
        _Color0  ("Color0",  Color)  = (1, 0, 0, 1)
        // Vector型は、xyzw成分を直接指定することができます。
        _Vector0 ("Vector0", Vector) = (1, 1, 1, 1)

        [Space]

        // [Gamma]はFloat型とVector型に有効で、ガンマ補正の対象であることを示します。
        // ガンマ補正とは、モニターなどに表示する際にそのまま表示すると実際の色とのひずみが発生するため
        // それにひずみの逆数をかけることで補正を行うこと
        [Gamma] _GammaFloat0  ("GammaFloat0",  Float)  = 0
        [Gamma] _GammaVector0 ("GammaVector0", Vector) = (1, 1, 1, 1)

        [Header(Toggle)]

        // [Toggle]はInspector上のUIがチェックボックスになります。Float型もしくはInt型に有効です
        [Toggle]                 _Toggle0        ("Toggle1",        Int)   = 0
        // [Toggle]と[MaterialToggle]の違いはありません。どちらも有効時に1、無効時に0を返します
        [MaterialToggle]         _Toggle1        ("Toggle0",        Float) = 0
        // [Toggle()]はチェックが有効な際に指定したキーワードが有効になります。
        // #multi_compile構文と合わせてシェーダバリアントのため利用されます
        [Toggle(KEYWORD_TOGGLE)] _KeywordToggle0 ("KeywordToggle0", Float) = 0

        [Header(Enum)]

        // 設定されたパラメータのUIがプルダウンメニューになります。FloatかInt型にのみ有効
        // C#側で定義されたpublicのEnumも使用できる
        [Enum(PropertiesEnum)]          _Enum0        ("Enum0",        Int)   = 0
        [Enum(ENUM0, 0, ENUM1, 5)]      _Enum1        ("Enum1",        Float) = 0
        // 選択されたキーワードが有効になります。シェーダバリアントで使用され
        // キーワードは、変数名_ラベルで定義されます。
        [KeywordEnum(Red, Green, Blue)] _KeywordEnum0 ("KeywordEnum0", Float) = 0

        [Header(Others)]

        // Inspector上にUIを表示しないようにします。特に使う必要性は感じない
        [HideInInspector] _Hide ("Hide", Float) = 0
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Opaque"
        }

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
            float4 _MainTex_ST;

            float _Enum0;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv     = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 color = tex2D(_MainTex, i.uv);
                return color;
            }

            ENDCG
        }
    }
}