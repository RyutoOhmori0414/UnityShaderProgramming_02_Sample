using UnityEngine;

public class RendererSet : MonoBehaviour
{
    [Tooltip("このオブジェクトを描画しているRenderer"), SerializeField]
    new private Renderer renderer;
    [Tooltip("レンダラーにセットされたマテリアルのインスタンスID"), SerializeField]
    int instanceID;

    [Tooltip("マテリアルに指定する値"), SerializeField, Range(0, 1)]
    private float floatValue;

    void Update ()
    {
        // Renderer.materialを参照した時点でマテリアルのインスタンスを複製する
        // 複製されるということは、マテリアルを一括で変更できなくなる
        // 不特定多数のオブジェクトで参照を行った場合、メモリリークの可能性もある
        // renderer.material.SetFloat("_FloatValue", floatValue);
        // instanceID = renderer.material.GetInstanceID();

        // インスタンスを複製せずにマテリアルを参照するときは.sharedMaterialを使う。
        // しかし、オブジェクト毎に異なる値を設定することはできない
        renderer.sharedMaterial.SetFloat("_FloatValue", floatValue);
        instanceID = renderer.sharedMaterial.GetInstanceID();
    }
}