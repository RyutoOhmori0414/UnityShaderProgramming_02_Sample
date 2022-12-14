using UnityEngine;

public class ShaderSet : MonoBehaviour
{
    [Range(0, 1)]
    public  float floatValue;

    void Update ()
    {
        // 同じ変数を持つすべてのシェーダの値を設定できる
        // 注意点としてこれでセットする変数は、プロパティに定義されていない必要がある。
        Shader.SetGlobalFloat("_FloatValue", floatValue);
    }
}