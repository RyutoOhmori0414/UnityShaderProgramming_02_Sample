// #includeには、多重定義の問題がある。
// それを防ぐためにLibrary側で#ifndefをつかい
// そのキーワードが定義されていないときにのみincludeさせる
#ifndef LIBRARY_INCLUDED
#define LIBRARY_INCLUDED

#include "Library.cginc"

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

#endif // LIBRARY_INCLUDED