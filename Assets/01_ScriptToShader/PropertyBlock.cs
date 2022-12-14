using UnityEngine;

public class PropertyBlock : MonoBehaviour
{
    [Tooltip("変更するマテリアルを持つRenderer"), SerializeField]
    new private Renderer renderer;
    [Tooltip("変更するマテリアル"), SerializeField]
    private Material material;
    [Tooltip("マテリアルのインスタンスID"), SerializeField]
    private int instanceID;

    [SerializeField, Range(0, 1)]
    private float floatValue;

    private MaterialPropertyBlock materialPropertyBlock;

    private void Start()
    {
        // マテリアルの値を直接変更しないため、インスタンスの複製は起こらない
        // 上書きする値だけを保持するため必要なメモリリソースは少なく済む
        // 複数のオブジェクトのマテリアルにわずかに異なる値を与えたい際に採用する
        materialPropertyBlock = new MaterialPropertyBlock();
    }

    void Update ()
    {
        materialPropertyBlock.SetFloat("_FloatValue", floatValue);

        // 適用する際はレンダラーにセットする
        renderer.SetPropertyBlock(materialPropertyBlock);

        instanceID = material.GetInstanceID();
    }
}