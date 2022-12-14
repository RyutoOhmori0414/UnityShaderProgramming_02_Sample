using UnityEngine;

public class MaterialSet : MonoBehaviour
{
    [Tooltip("値を変更するマテリアル"), SerializeField]
    private Material _material;

    [Tooltip("変更する値"), Range(0, 1), SerializeField]
    private float _floatValue;
    /// <summary>_FloatValueのID</summary>
    private int   _floatValueId;

    void Start ()
    {
        // プロパティのIDを変数名で取得している
        _floatValueId = Shader.PropertyToID("_FloatValue");
    }

    void Update ()
    {
        // SetFloatは第一引数をstringでとることもできるが、
        // 内部的にIDに変換されているため、
        // 複数回そのプロパティを変更する際はIDで指定する方が結果的に処理が少ない
        _material.SetFloat("_FloatValue", _floatValue);
        _material.SetFloat(_floatValueId,  _floatValue);
    }
}